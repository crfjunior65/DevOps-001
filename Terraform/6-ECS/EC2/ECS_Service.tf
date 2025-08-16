/*
resource "aws_ecs_service" "mongo" {
  name            = "mongodb"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.mongo.arn
  desired_count   = 3
  iam_role        = aws_iam_role.foo.arn
  depends_on      = [aws_iam_role_policy.foo]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = "mongo"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}

resource "aws_ecs_service" "bar" {
  name                = "bar"
  cluster             = aws_ecs_cluster.foo.id
  task_definition     = aws_ecs_task_definition.bar.arn
  scheduling_strategy = "DAEMON"
}
*/

# Create the ECS Service
resource "aws_ecs_service" "ecs_service" {
  name            = "webapp-svc"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 2 # we want to run 2 instances of the container image on our ECS cluster

  network_configuration {
    security_groups = [data.terraform_remote_state.sg.outputs.sg_bia_web]
    subnets         = [data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[0]]
  }

  force_new_deployment = true

  placement_constraints {
    type = "distinctInstance"
  }

  triggers = {
    redeployment = timestamp()
  }
  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
    weight            = 100
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tg.arn
    container_name   = "webapp-ctr"
    container_port   = 80
  }

  depends_on = [
    aws_autoscaling_group.ecs_asg,
  ]
}
