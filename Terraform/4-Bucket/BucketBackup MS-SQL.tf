resource "aws_s3_bucket" "rds_backup_bucket" {
  bucket = "crfjunior-rds-backup"
  #acl    = "private"
  #lifecycle {
  #  prevent_destroy = true
  #}
  /*
  versioning {
    enabled = false #true
  }
*/
  tags = {
    Name = "crfunior-backup-RDS"

  }
}

/*
# Cria uma política de acesso para o bucket
resource "aws_s3_bucket_policy" "rds_backup_bucket_policy" {
  bucket = aws_s3_bucket.rds_backup_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        }
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.rds_backup_bucket.arn,
          "${aws_s3_bucket.rds_backup_bucket.arn}/*"
        ]
      }
    ]
  })
}
*/















/*
Definições Site Statico
resource "aws_s3_bucket_website_configuration" "s3_bia_static" {
  bucket = aws_s3_bucket.s3_bia_static.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

# Bloquear configurações padrão de acesso privado (se necessário)
resource "aws_s3_bucket_public_access_block" "s3_bia_static" {
  bucket = aws_s3_bucket.s3_bia_static.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Permitir acesso público ao site (CUIDADO: Isso expõe os arquivos publicamente)
resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.s3_bia_static.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.s3_bia_static.arn}/*"
    }
  ]
}
POLICY
}
*/

# Upload de um arquivo index.html (Opcional)
#resource "aws_s3_object" "index_html" {
#  bucket       = aws_s3_bucket.s3_bia_static.id
#  key          = "index.html"
#  source       = "index.html" # O arquivo precisa estar na mesma pasta do Terraform
#  content_type = "text/html"
#}


/*
resource "aws_s3_bucket_public_access_block" "s3_bia_static" {
  bucket = aws_s3_bucket.s3_bia_static.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
*/
