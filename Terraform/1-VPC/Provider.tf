# --- AWS ---

provider "aws" {
  # Configuration options
  region  = var.AWS_REGION
  profile = "crfjunior-outlook"
  #alias  = "us-1"
  default_tags {
    tags = {
      Terraform    = "true"
      Environment  = "Projeto"
      Management   = "Terraform"
      RegiaoCriada = var.AWS_REGION
    }
  }
}

provider "aws" {
  # Configuration options
  region  = "sa-east-1"
  profile = "crfjunior-outlook"
  alias   = "sa-1"
  default_tags {
    tags = {
      Terraform    = "true"
      Environment  = "Projeto"
      Management   = "Terraform"
      RegiaoCriada = "sa-east-1"
    }
  }
}
