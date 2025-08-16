locals {
  common_tags = {
    Terraform   = "true"
    Environment = var.environment
    Management  = "Terraform"
    Owner       = var.owner
    Project     = "Projeto-${var.environment}"
  }
  azs = ["us-east-1a", "us-east-1b"] # Suas AZs existentes
}

locals {
  # Crie uma lista de AZs usando o valor de `var.AWS_REGION`.
  # Isso pode ser usado como um valor padrão ou para construir a lista real.
  all_azs = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]
}