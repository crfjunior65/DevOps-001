terraform {
  backend "s3" {
    bucket = "crfjunior-terraform-state-bia"
    key    = "sg/terraform.tfstate"
    region = "us-east-2"
    #dynamodb_table = "meu-lock-dynamodb"  # Para locking
    #encrypt        = true                 # Criptografar o arquivo de estado
  }
}
