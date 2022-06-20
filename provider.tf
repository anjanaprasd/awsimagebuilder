terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.15.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket         = "$s3bucket-name" #add your s3 bucket name.
    key            = "terraform.tfstate"
    region         = "$your_aws_region"      #your aws region.
    dynamodb_table = "$dynamo_db_table_name" #aws dynamodb table name for created for remote backend.
  }
}





