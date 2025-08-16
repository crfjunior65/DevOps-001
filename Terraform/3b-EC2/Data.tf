#Data Pasta Orquestraor
/*
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=al2023-ami-*-x86_64" \
  --query 'sort_by(Images, &CreationDate)[-5:][].[ImageId,Name,CreationDate]' \
  --output table

  aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=al2023-ami-2023*1-x86_64" \
  --query 'sort_by(Images, &CreationDate)[-5:][].[ImageId,Name,CreationDate]' \
  --output table
*/
# Dados IAMIs - aws ec2 describe-images --owners amazon |grep noble-24.04 |grep Name


data "terraform_remote_state" "Orquestrador" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "Orquestrador/terraform.tfstate"
    #key    = "RemoteState/vpc/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

# Data Pasta Orquestrador
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "vpc/terraform.tfstate"
    #key    = "RemoteState/vpc/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "sg/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
/*
data "terraform_remote_state" "efs" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "efs/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
*/
data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "iam/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "rds" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "rds/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
