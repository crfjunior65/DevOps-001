#output "website_url" {
#  value = aws_s3_bucket_website_configuration.s3_bia_static.website_endpoint
#}

output "s3_bucket_name" {
  value = aws_s3_bucket.rds_backup_bucket.bucket
}
