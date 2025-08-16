# ECS Cluster
resource "aws_ecs_cluster" "fargate_cluster" {
  name = "bia-fargate-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "bia-fargate-cluster"
  }
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "fargate_log_group" {
  name              = "/ecs/bia-fargate"
  retention_in_days = 7

  tags = {
    Application = var.environment
    Environment = var.autor
  }
}

# IAM Role for Task Execution
resource "aws_iam_role" "fargate_task_execution_role" {
  name = "fargate-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "fargate_task_execution_policy" {
  role       = aws_iam_role.fargate_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task Definition
resource "aws_ecs_task_definition" "fargate_task" {
  family                   = "bia-fargate-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.fargate_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "bia-container"
      image     = "023770199924.dkr.ecr.us-east-1.amazonaws.com/bia:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "DB_USER", value = "postgres" },
        { name = "DB_PWD", value = "postgres" },
        { name = "DB_HOST", value = "bia.c4n0kckw4m91.us-east-1.rds.amazonaws.com" },
        { name = "DB_PORT", value = "5432" }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.fargate_log_group.name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

# Security Group for ECS Service
resource "aws_security_group" "fargate_sg" {
  name_prefix = "fargate-sg"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fargate-security-group"
  }
}

# ECS Service
resource "aws_ecs_service" "fargate_service" {
  name            = "bia-fargate-service"
  cluster         = aws_ecs_cluster.fargate_cluster.id
  task_definition = aws_ecs_task_definition.fargate_task.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.fargate_sg.id]
    subnets          = data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id
    assign_public_ip = true
  }

  depends_on = [aws_iam_role_policy_attachment.fargate_task_execution_policy]
}
