terraform {
  backend "s3" {
    bucket = "crfjunior-terraform-state-bia"
    key    = "ecs-fargate/terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "meu-lock-dynamodb"  # Para locking
    #encrypt        = true                 # Criptografar o arquivo de estado
  }
}
