# --- AWS ---

provider "aws" {
  # Configuration options
  #alias = "us-1"
  #profile = crfjunior072024
  region = "us-east-1"
  #version = "~> 5.0"

  default_tags {
    tags = {
      Terraform    = "true"
      Environment  = "Projeto-Bia"
      Management   = "Terraform"
      RegiaoCriada = "us-east-1"
    }
  }
}

provider "aws" {
  # Configuration options
  alias = "us-2"
  #profile = crfjunior072024
  region = "us-east-2"
  #version = "~> 5.0"

  default_tags {
    tags = {
      Terraform    = "true"
      Environment  = "Projeto"
      Management   = "Terraform"
      RegiaoCriada = "us-east-2"
    }
  }
}

provider "aws" {
  # Configuration options
  #alias = "sa-east-1"
  #profile = crfjunior072024
  region = "sa-east-1"
  alias  = "sa-1"
  default_tags {
    tags = {
      Terraform    = "true"
      Environment  = "Projeto"
      Management   = "Terraform"
      RegiaoCriada = "sa-east-1"
    }
  }
}
