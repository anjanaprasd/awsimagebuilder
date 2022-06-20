data "aws_iam_role" "ArnRole" {
  name = "$IAM1-role name" # add your aws IAM role name here.
}

## retrive exsiting aws subnet id using data function.
data "aws_subnet" "selected" {
  id = var.subnet_id
}

## retrive exsiting aws SG id using data function.
data "aws_security_group" "sg1" {
  id = var.security_group_id
}


# creating AWS image builder pipeline.
resource "aws_imagebuilder_image_pipeline" "AMIexample" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.imager_recipe.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.infrastructure_configuration.arn
  name                             = "AmiPipeline"
  status                           = "ENABLED"
  description                      = "This is a test AmiPipeline "

  # you can remove this block if you are planning to trigger pipeline mannually.
  schedule {
    schedule_expression                = "cron(0 8 ? * tue)"
    pipeline_execution_start_condition = "EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE"
  }

  image_tests_configuration {
    image_tests_enabled = true
    timeout_minutes     = 120
  }

  tags = {
    "Name" = "AmiPipeline"
  }

}

# This is a inline imagebuilder component. 
resource "aws_imagebuilder_component" "AMIexample" {
  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = ["yum install httpd -y"]
        }
        name      = "Loginexample"
        onFailure = "Continue"
      }]
    }]
    schemaVersion = 1.0
  })
  name     = "example"
  platform = "Linux"
  version  = "1.0.0"
}


#### create builder component using YAML file.
resource "aws_s3_bucket_object" "AMIYamL" {
  bucket = var.aws_s3_bucket_object
  key    = "SmsLogin-Custom.yml"
  source = "SmsLogin-Custom.yml"
  etag   = filemd5("SSM-Custom.yml")
}

resource "aws_imagebuilder_component" "SSMComponent" {
  name     = "AMILogin-Demo"
  platform = "Linux"
  uri      = "s3://${var.aws_s3_bucket_object}/SSM-Custom.yml"
  version  = "1.0.0"
  depends_on = [
    aws_s3_bucket_object.AMIYamL
  ]

}

resource "aws_imagebuilder_image" "AMIBuilder" {
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.AMIexample.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.imager_recipe.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.infrastructure_configuration.arn
}


resource "aws_imagebuilder_image_recipe" "imager_recipe" {
  block_device_mapping {
    device_name = "/dev/xvdb"

    ebs {
      delete_on_termination = true
      volume_size           = var.ebsvol_size
      volume_type           = var.ebs_type
    }
  }


  component {
    component_arn = aws_imagebuilder_component.SSMComponent.arn
  }

  name         = var.name_recipe
  parent_image = var.image_id
  version      = var.image_version

}

resource "aws_s3_bucket" "AMILogs" {
  bucket = "$yourS3bucketname"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


resource "aws_imagebuilder_infrastructure_configuration" "infrastructure_configuration" {
  description           = "infastructure component build"
  instance_profile_name = "login-imagebuilder-tf"
  instance_types        = ["t2.nano"] // need to set var
  key_pair              = var.keypair_name
  name                  = "AMIDemo"
  security_group_ids    = [data.aws_security_group.sg1.id]
  #sns_topic_arn                 = aws_sns_topic.example.arn # enable this if you're planning to enable SNS.
  subnet_id                     = data.aws_subnet.selected.id
  terminate_instance_on_failure = true

  logging {
    s3_logs {
      s3_bucket_name = "$your-loggingbucket-name" #s3 bucket name for logging.
      s3_key_prefix  = "Imagebuilder-Logs"        #s3 prefix to stroe logs.
    }
  }

  depends_on = [
    aws_s3_bucket.AMILogs
  ]


  tags = {
    Name = "Infra"
  }

}



resource "aws_imagebuilder_distribution_configuration" "AMIexample" {
  name = "SmsLogin"
  distribution {
    ami_distribution_configuration {
      ami_tags = {
        Product     = "AMI"
        Environment = "Dev"
      }

      name = "AMI-linux-{{ imagebuilder:buildDate }}"
    }

    region = "us-east-1"
  }
}

