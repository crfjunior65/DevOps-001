# --- AWS ---

provider "aws" {
  # Configuration options
  #alias = "east-1"
  #profile = crfjunior072024
  region = "us-east-1"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "Projeto-${var.environment}"
      Management  = "Terraform"
      Owner       = "Junior_Fernandes"
    }
  }
}

provider "aws" {
  # Configuration options
  alias = "east-2"
  #profile = crfjunior072024
  region = "us-east-2"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "Projeto-${var.environment}"
      Management  = "Terraform"
      Owner       = "Junior_Fernandes"
    }
  }
}
