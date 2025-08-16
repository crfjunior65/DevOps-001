# --- AWS ---

provider "aws" {
  # Configuration options
  #alias = "us-east-1"
  #profile = crfjunior072024
  region  = var.AWS_REGION
  profile = "crfjunior-outlook"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = var.environment
      Management  = "Terraform"
    }
  }
}
