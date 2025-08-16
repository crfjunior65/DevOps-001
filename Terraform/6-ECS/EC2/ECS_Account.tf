resource "aws_ecs_account_setting_default" "test" {
  name  = "taskLongArnFormat"
  value = "enabled"
}
