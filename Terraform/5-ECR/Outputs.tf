output "ecr_repository_arn" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.repository-bia.arn
  #aws_ecr_repository.repository-bia.repository.ecr_repository_arn
}

output "ecr_repository_id" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.repository-bia.id
}

output "ecr_repository_name" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.repository-bia.name
}

output "ecr_repository_tags_all" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.repository-bia.tags_all
}

output "ecr_repository_registry_id" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.repository-bia.registry_id
}

output "ecr_repository_url" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.repository-bia.repository_url
}
