# Create an Auto Scaling Group (ASG)
# (and associate it with the lauch template created previously)
resource "aws_autoscaling_group" "ecs_asg" {
  vpc_zone_identifier = [
    data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[0]
  ]
  desired_capacity = 2
  max_size         = 2
  min_size         = 2

  launch_template {
    id      = aws_launch_template.ec2_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}
