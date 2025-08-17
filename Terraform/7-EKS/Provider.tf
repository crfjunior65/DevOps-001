provider "aws" {
  region = var.AWS_REGION

  default_tags {
    tags = {
      Environment = "dev"
      Project     = "DevOps-001"
      ManagedBy   = "Terraform"
      Owner       = "Junior"
    }
  }
}
