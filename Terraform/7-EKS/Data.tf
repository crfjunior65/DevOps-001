# Data source para VPC
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "vpc/terraform.tfstate"
    region = var.AWS_REGION
  }
}

# Data source para AMI mais recente do EKS
data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.kubernetes_version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

# Data source para availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Data source para caller identity
data "aws_caller_identity" "current" {}

# Data source para região atual
data "aws_region" "current" {}
