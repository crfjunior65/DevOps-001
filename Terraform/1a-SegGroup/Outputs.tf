/*
output "security_group_ids" {
  description = "IDs dos security groups criados"
  value = {
    for k, v in aws_security_group.main : k => v.id
  }
}
*/