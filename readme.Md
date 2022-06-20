Hi Everyone.
This terraform code will help you to deploy AWS Image builder pipeline including all components in image builder. In this senario, I've used a custom SSM playbook to configure my AMI. Adding custom application user and configure tomcat service on the new AMI.

Install aws-cli and terraform packages in your local system.

run aws configure command to authenticate with AWS. Once you execute the aws configure it will ask your 
AWS_ACCESS_KEY = xxxxxxxxxxxxxx
AWS_SECRET_KEY = xxxxxxxxxxxxxx
REGION = xxxxxx

Execute this code.
Step 01.
Install terraform in your local system.
Step 02.
Run terraform init command to download required API packages.
Step 03.
Run terraform fmt command to format your code.
Step 04.
terraform validate command to validate your command, this will ensure all code is valid.
Step 05.
terraform plan command to see the execution plan before apply it to real enviroment.
Step 06.
run terraform apply command.

Your terraform state file will be store in given S3 bucket.




