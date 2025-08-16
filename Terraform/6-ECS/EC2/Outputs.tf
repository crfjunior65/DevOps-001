output "ecs_cluster_name" {
  description = "Nome do cluster ECS"
  value       = aws_ecs_cluster.ecs_cluster.name
}

output "ecs_cluster_arn" {
  description = "ARN do cluster ECS"
  value       = aws_ecs_cluster.ecs_cluster.arn
}

output "alb_dns_name" {
  description = "DNS name do Application Load Balancer"
  value       = aws_lb.ecs_alb.dns_name
}

output "alb_zone_id" {
  description = "Zone ID do Application Load Balancer"
  value       = aws_lb.ecs_alb.zone_id
}

output "ecs_service_name" {
  description = "Nome do serviço ECS"
  value       = aws_ecs_service.ecs_service.name
}
