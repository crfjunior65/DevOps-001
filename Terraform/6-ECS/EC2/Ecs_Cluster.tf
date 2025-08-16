/*
resource "aws_ecs_cluster" "foo" {
  name = "white-hart"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
*/

# Configure ECS cluster

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "bia-cluster"
  tags = {
    Name = "bia-cluster"
  }
}

resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  name = "webapp-cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ecs_asg.arn
    managed_scaling {
      maximum_scaling_step_size = 4
      minimum_scaling_step_size = 2
      status                    = "ENABLED"
      target_capacity           = 100 # o ECS tentará manter a utilização do grupo de Auto Scaling em 100% da capacidade total
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "bia_capacity_providers" {
  cluster_name       = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
  }
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.environment}-logs"

  tags = {
    Application = var.environment
    Environment = var.autor
  }
}
