/*
#terraform {
#  backend "s3" {
#    bucket = "crfjunior-remote-state"
#    key    = "vpc/terraform.tfstate"
#    region = "us-east-1"
#    #dynamodb_table = "meu-lock-dynamodb"  # Para locking
#    #encrypt        = true                 # Criptografar o arquivo de estado
#  }
#}
*/

# variable "environment" {
#   type    = string
#   default = "bia"
# }

resource "aws_s3_bucket" "s3_state" {
  bucket = "crfjunior-terraform-state-bia"

  #lifecycle {
  #  prevent_destroy = false #true
  #}
  force_destroy = true
  lifecycle {
    prevent_destroy = false #true
  }

  tags = {
    Name = "crfunior-terraform-state-bia"

  }
}

resource "aws_s3_bucket_versioning" "terrafor_state_versioning" {
  bucket = aws_s3_bucket.s3_state.id
  versioning_configuration {
    status = "Disabled"
    #status = "Enabled"
  }
}


/*
# Criação da Tabela DynamoDB para lock do Terraform State
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "crfjunior-terraform-locks-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-locks-${var.environment}"
  }
}
*/


/*
│ Error: reading S3 Bucket (crfjunior-terraform-state-zabbix): operation error S3: HeadBucket, https response error StatusCode: 403, RequestID: DRBFRV1RPJTNS0JC, HostID: W/UG4JRCmt8niibEDSWTyUnqHbnySpZH+RPDH3ccXH4tJliqXO4ehqsAeHHZa6i9tSVwcszcto4=, api error Forbidden: Forbidden
│
│   with aws_s3_bucket.s3_state,
│   on State.tf line 19, in resource "aws_s3_bucket" "s3_state":
│   19: resource "aws_s3_bucket" "s3_state" {
│


resource "aws_s3_bucket" "s3_state" {
  bucket = "crfjunior-terraform-state-${var.environment}"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "crfunior-terraform-state-${var.environment}"

  }
}

resource "aws_s3_bucket_acl" "acl_s3_state" {
  bucket = aws_s3_bucket.s3_state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terrafor_state_versioning" {
  bucket = aws_s3_bucket.s3_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Criação da Tabela DynamoDB para lock do Terraform State
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "crfjunior-terraform-locks-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-locks-${var.environment}"
  }
}
*/
