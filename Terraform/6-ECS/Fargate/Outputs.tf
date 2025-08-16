output "fargate_cluster_name" {
  description = "Nome do cluster ECS Fargate"
  value       = aws_ecs_cluster.fargate_cluster.name
}

output "fargate_cluster_arn" {
  description = "ARN do cluster ECS Fargate"
  value       = aws_ecs_cluster.fargate_cluster.arn
}

output "fargate_service_name" {
  description = "Nome do serviço ECS Fargate"
  value       = aws_ecs_service.fargate_service.name
}

output "fargate_task_definition_arn" {
  description = "ARN da task definition"
  value       = aws_ecs_task_definition.fargate_task.arn
}
