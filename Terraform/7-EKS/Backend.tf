terraform {
  backend "s3" {
    bucket         = "crfjunior-terraform-state-bia"
    key            = "eks/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
