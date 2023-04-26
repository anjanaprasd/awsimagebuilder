####AWS Image Builder Pipeline Deployment with Terraform

This Terraform code will help you deploy the AWS Image Builder pipeline to create an Amazon Machine Image (AMI) using a custom SSM playbook. The playbook includes configuration for a custom application user and sets up the Tomcat service on the new AMI.

Before you execute this Terraform code, ensure that you have installed Terraform and the AWS Command Line Interface (CLI) in your local system.
AWS Configuration

Use the following command to authenticate with AWS:

aws configure

The command will prompt you to enter the following details:

makefile

AWS_ACCESS_KEY = xxxxxxxxxxxxxx
AWS_SECRET_KEY = xxxxxxxxxxxxxx
REGION = xxxxxx

Execution Steps

Follow the below steps to execute the Terraform code:

    Install Terraform in your local system.
    Run the command terraform init to download the required API packages.
    Run the command terraform fmt to format your code.
    Run the command terraform validate to validate your code.
    Run the command terraform plan to see the execution plan before applying it to a real environment.
    Finally, run the command terraform apply to apply the Terraform code.

Note that the Terraform state file will be stored remotely, in this scenario it is stored in the S3 bucket.


