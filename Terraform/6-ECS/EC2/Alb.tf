# Configure the Application Load Balancer (ALB)
# (its listener, and the TARGET GROUP)
resource "aws_lb" "ecs_alb" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.sg.outputs.sg_bia_web]
  subnets            = data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id

  # access_logs {
  #   bucket  = "nome-do-seu-bucket-de-logs" # Substitua pelo nome do seu bucket S3
  #   prefix  = "alb-logs"
  #   enabled = false
  # }

  tags = {
    Name = "ecs-alb"
  }
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "webapp-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  #  vpc_id      = "vpc-068827f882e554167" # VPC default (COMENTAR ESTA LINHA PRA VER O QUE ACONTECE)
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_vpc_id # VPC default (COMENTAR ESTA LINHA PRA VER O QUE ACONTECE)

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward" # ecaminha tráfeto para o TARGET GROUP
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}
