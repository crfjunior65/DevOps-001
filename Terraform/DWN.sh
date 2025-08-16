#!/bin/bash
clear

#cd /home/junior/Dados/FormacaoAWS/Terraform

#drwxrwxr-x  3 junior junior 4,0K out 24 16:06 1-Vpc
#drwxrwxr-x  3 junior junior 4,0K out 29 21:10 2-Rds
#drwxrwxr-x  4 junior junior 4,0K out 18 21:41 3-Efs
#drwxrwxr-x  3 junior junior 4,0K out 23 21:40 4-Alb
#drwxrwxr-x  3 junior junior 4,0K out 24 14:47 5-Ecr
#drwxrwxr-x  3 junior junior 4,0K out 31 19:00 6-Ecs

#0-State

cd 6-ECS
cd EC2
pwd
terraform destroy -auto-approve 
cd ..
#cd Fargate
#pwd
#terraform destroy -auto-approve 
#cd ..
cd ..

cd 5-ECR
pwd
aws ecr delete-repository --repository-name bia --region us-east-1 --force
terraform destroy -auto-approve 
cd ..

#cd 4-Bucket
#pwd
#aws s3 ls s3://nome-do-seu-bucket --recursive
#aws s3 rb s3://nome-do-seu-bucket --force
##aws s3 rm s3://crfjunior-terraform-state-bia --recursive
#aws s3 rb s3://crfjunior-terraform-state-zabbix --force #Remove Bucket
#aws s3api delete-objects --bucket nome-do-seu-bucket --delete "$(aws s3api list-object-versions \
#  --bucket nome-do-seu-bucket \
#  --output=json \
#  --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')"

#aws s3api delete-bucket --bucket nome-do-seu-bucket

#terraform destroy -auto-approve
#cd ..

cd 4-Alb
#terraform destroy -auto-approve
##terraform plan -out plan.out && terraform destroy plan.out
#cd ..

cd 3-RDS
pwd
terraform destroy -auto-approve 
cd ..

cd 3a-Orquestrador
#cd ZbxDb
#pwd
#terraform destroy -auto-approve
#cd ..
pwd
terraform destroy -auto-approve
cd ..

#cd 2-EFS
#pwd
#terraform destroy -auto-approve
#cd ..

cd 1b-IAM
pwd
terraform destroy -auto-approve
cd ..

cd 1a-SegGroup
pwd
terraform destroy -auto-approve
cd ..

cd 1-VPC
pwd
terraform destroy -auto-approve
cd ..
