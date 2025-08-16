provider "aws" {
  region = var.regiao

  default_tags {
    tags = {
      Terraform   = "true"
      Environment = var.environment
      Projeto     = var.projeto
      Cliente     = var.cliente
      Autor       = var.autor
    }
  }
}
