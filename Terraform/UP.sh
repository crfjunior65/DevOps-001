#!/bin/bash

pwd
terraform fmt --recursive 
#>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP

#drwxrwxr-x  2 junior junior 4,0K set 19 19:06 0-GitHub-Sync
#drwxrwxr-x  3 junior junior 4,0K fev  6 18:09 0-TerraformState
#drwxrwxr-x  3 junior junior 4,0K fev  6 20:23 1a-SegGroup
#drwxrwxr-x  3 junior junior 4,0K fev  6 20:46 1b-IAM
#drwxrwxr-x  3 junior junior 4,0K fev  6 18:15 1-VPC
#drwxrwxr-x  3 junior junior 4,0K set 19 11:23 2a-Orquestrador
#drwxrwxr-x  4 junior junior 4,0K fev  6 20:50 2-EFS
#drwxrwxr-x  3 junior junior 4,0K fev  6 18:57 3-RDS
#drwxrwxr-x  2 junior junior 4,0K set 17 17:53 4-Bucket
#drwxrwxr-x  4 junior junior 4,0K fev  6 16:50 5-ECR
#drwxrwxr-x  3 junior junior 4,0K set 24 19:54 6-ECS

#0-State
cd 1-VPC
pwd
pwd 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
terraform init -reconfigure
terraform validate
terraform plan -out plan.out 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && 
terraform apply plan.out 
terraform output >OUTPUT
cd ..

cd 1a-SegGroup
pwd
pwd 
#>>/home/junior/Dados/FormacaoAWS/Terraform/LogTerraform-UP
terraform init -reconfigure
terraform validate
terraform plan -out plan.out 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && 
terraform apply plan.out 
terraform output >OUTPUT
cd ..

cd 1b-IAM
pwd
pwd 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
terraform init -reconfigure
terraform validate
terraform plan -out plan.out 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && 
terraform apply plan.out 
terraform output >OUTPUT
cd ..

#cd 2-EFS
#pwd
#pwd >>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
#terraform init -reconfigure
#terraform validate
#terraform plan -out plan.out >>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && terraform apply plan.out 
#terraform output >OUTPUT
#cd .. 

cd 3-RDS
pwd
pwd 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
terraform init -reconfigure
terraform validate
terraform plan -out plan.out 
##>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && 
terraform apply plan.out 
terraform output >OUTPUT
cd ..

cd 3a-Orquestrador
pwd
pwd 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
#terraform init -reconfigure
#terraform validate
#terraform plan -out plan.out 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && 
#terraform apply plan.out 
#terraform output >OUTPUT

#cd ZbxDb
#pwd
#pwd >>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
##terraform init -reconfigure
#terraform validate
#terraform plan -out plan.out >>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && terraform apply plan.out 
#terraform output >OUTPUT
#cd ..
cd ..

cd 3b-EC2
pwd
pwd 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
##terraform init -reconfigure
##terraform validate
##terraform plan -out plan.out 
###>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && 
##terraform apply plan.out 
##terraform output >OUTPUT
cd ..

cd 4-Bucket
pwd
pwd 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
#terraform init -reconfigure
#terraform validate
#terraform plan -out plan.out && terraform apply plan.out 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
#terraform output >OUTPUT
cd ..

cd 5-ECR
pwd
pwd 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
terraform init -reconfigure
terraform validate
terraform plan -out plan.out 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && 
terraform apply plan.out 
terraform output >OUTPUT
cd ..

cd 6-ECS
pwd
pwd 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
cd EC2
pwd
#pwd >>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
##terraform init -reconfigure
##terraform validate
##terraform plan -out plan.out 
#>>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && 
##terraform apply plan.out 
##terraform output >OUTPUT
cd ..
#pwd
#cd Fargate
#pwd
#pwd >>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP
##terraform init -reconfigure
#terraform validate
#terraform plan -out plan.out >>/home/junior/Dados/FormacaoAWS/MentoriaDesafioLABS_2.0/Terraform/LogTerraform-UP && terraform apply plan.out 
#terraform output >OUTPUT
#cd ..
#pwd 
cd ..
pwd

#cd Orquestrador
#pwd
#terraform init -reconfigure
#terraform plan -out plan.out && terraform apply plan.out
#terraform output >OUTPUT
#cd ..
##### code .
