variable "region" {
  type        = string
  default     = "us-east-1"
  description = "default aws region"
}

variable "ebsvol_size" {
  type        = number
  default     = 50
  description = "/opt/apps mount size"


}

variable "ebs_type" {
  type    = string
  default = "gp2"
}

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default     = "null"

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}


variable "image_version" {
  type    = string
  default = "1.0.0"

}


variable "subnet_id" {
  default = "null"
}

variable "security_group_id" {
  type    = string
  default = "null"
}


variable "aws_s3_bucket_object" {
  type        = string
  description = "The S3 bucket name to upload image builder componet file."
  default     = "null"
}


variable "name_recipe" {
  type        = string
  description = "Image builder recipe name"
  default     = "null"

}

variable "keypair_name" {
  default     = "null"
  description = "ssh key name use to ssh AMI"
  type        = string

}

