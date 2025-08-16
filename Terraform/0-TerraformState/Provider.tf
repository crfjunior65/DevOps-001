# --- AWS ---

provider "aws" {
  region  = var.AWS_REGION
  profile = "crfjunior-outlook"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = var.Environment
      Project     = "DevOps-Projetos_AWS"
      Owner       = "CRF_Junior"
      CreatedBy   = "Terraform"
      Management  = "Terraform"
    }
  }
}
