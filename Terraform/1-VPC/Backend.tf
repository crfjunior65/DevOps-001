#variable "environment" {
#  type    = string
#  default = "bia"
#}

terraform {
  backend "s3" {
    bucket = "crfjunior-terraform-state-bia"
    key    = "vpc/terraform.tfstate"
    region = "us-east-2" #var.AWS_REGION
    #dynamodb_table = "meu-lock-dynamodb"  # Para locking
    #encrypt        = true                 # Criptografar o arquivo de estado
  }
}
