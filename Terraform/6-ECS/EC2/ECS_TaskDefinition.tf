/*
resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "service-first"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
    {
      name      = "second"
      image     = "service-second"
      cpu       = 10
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
    }
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}

resource "aws_ecs_task_definition" "service" {
  family                = "service"
  container_definitions = file("task-definitions/service.json")

  volume {
    name = "service-storage"

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.fs.id
      root_directory          = "/opt/data"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2999
      authorization_config {
        access_point_id = aws_efs_access_point.test.id
        iam             = "ENABLED"
      }
    }
  }

  volume {
    name = "service-storage"

    docker_volume_configuration {
      scope         = "shared"
      autoprovision = true
      driver        = "local"

      driver_opts = {
        "type"   = "nfs"
        "device" = "${aws_efs_file_system.fs.dns_name}:/"
        "o"      = "addr=${aws_efs_file_system.fs.dns_name},rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport"
      }
    }
  }
}
*/

# Create ECS Task Definition/Template
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "webapp"
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  #execution_role_arn = "arn:aws:iam::684644783255:role/ecsTaskExecutionRole"
  #task_role_arn = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  #execution_role_arn = data.terraform_remote_state.iam.outputs.iam_ecs_task_execution_role.arn
  cpu    = 1024 # equivale a 1 vCPU - QUANTIDADE DE CPU A SER ALOCADA PARA A ECS
  memory = 256  # 256 MiB = 0.25 GiB
  #task_role_arn = data.terraform_remote_state.iam.outputs.iam_ecs_task_role.id
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([{
    name      = "webapp-ctr",
    image     = "023770199924.dkr.ecr.us-east-1.amazonaws.com/bia:latest", # image URL of the application image
    cpu       = 1024,                                                      # equivale a 1 vCPU - QUANTIDADE DE CPU A SER ALOCADA PARA A ECS
    memory    = 256,                                                       # 256 MiB = 0.25 GiB
    essential = true,                                                      # a execução do container é essencial para a tarefa
    portMappings = [{
      containerPort = 80,
      hostPort      = 8080,
      protocol      = "tcp"
    }],
    environment = [
      { name = "DB_USER", value = "postgres" },
      { name = "DB_PWD", value = "postgres" },
      { name = "DB_HOST", value = "bia.c4n0kckw4m91.us-east-1.rds.amazonaws.com" },
      { name = "DB_PORT", value = "5432" }
    ],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.log-group.name,
        "awslogs-region"        = "us-east-1",
        "awslogs-stream-prefix" = "webapp"
      }
    }
  }])
  #execution_role_arn = data.terraform_remote_state.iam.outputs.iam_ecs_task_execution_role.arn
  #task_role_arn      = data.terraform_remote_state.iam.outputs.iam_ecs_task_role.arn
}
