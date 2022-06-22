Hi Everyone.
The terraform code will help you in deploying the AWS Image builder pipeline. In this scenario, I've used a custom SSM playbook to bake my AMI based on my pre-requisites to reduce the deployment time. 
 It contains custom application user configuration and configures Tomcat service on the new AMI.


Install aws-cli and terraform packages in your local system.

# aws configure.
run aws configure command to authenticate with AWS. Once you execute the aws configure it will ask your 
AWS_ACCESS_KEY = xxxxxxxxxxxxxx
AWS_SECRET_KEY = xxxxxxxxxxxxxx
REGION = xxxxxx

Execute this code.
# Step 01.
Install terraform in your local system.
# Step 02.
Run terraform init command to download required API packages.
# Step 03.
Run terraform fmt command to format your code.
# Step 04.
terraform validate command to validate your command, this will ensure all code is valid.
# Step 05.
terraform plan command to see the execution plan before apply it to real enviroment.
# Step 06.
run terraform apply command.

Terraform state file will be stored remotely in this scenario it's in the S3 bucket.




