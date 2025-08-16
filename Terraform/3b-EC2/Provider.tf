# --- AWS ---

provider "aws" {
  # Configuration options
  #alias = "east-1"
  #profile = crfjunior072024
  region = "us-east-1"
  #version = "~> 5.0"

  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "Projeto"
      Management  = "Terraform"
    }
  }
}

provider "aws" {
  # Configuration options
  alias = "east-2"
  #profile = crfjunior072024
  region = "us-east-2"
  #version = "~> 5.0"

  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "Projeto"
      Management  = "Terraform"
    }
  }
}
