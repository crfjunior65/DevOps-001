output "ssm_role" {
  value = aws_iam_role.ssm_role.id
}

output "ssm_atach_role" {
  value = aws_iam_role_policy_attachment.ssm_managed_policy
}

#aws_iam_instance_profile.ssm_profile
output "iam_ssm_profile" {
  description = "Role SSM Profile"
  value       = aws_iam_instance_profile.ssm_profile
}

output "iam_instance_profile_ssm_profile_name" {
  description = "Profile Name"
  value       = aws_iam_instance_profile.ssm_profile
}

#aws_iam_role" "ec2_s3_role
output "iam_ec2_s3_role" {
  value = aws_iam_role.ec2_s3_role
}
#aws_iam_role_policy_attachment" "s3_managed_policy
output "iam_s3_atach_role" {
  value = aws_iam_role_policy_attachment.s3_managed_policy
}
#aws_iam_instance_profile" "s3_profile
output "iam_s3_profile" {
  value = aws_iam_instance_profile.s3_profile
}

#AWS  Identifier
output "aws_ident" {
  value = data.aws_caller_identity.current.account_id
  #       data "aws_caller_identity" "current"
}

output "iam_ecs_atach_role" {
  value = aws_iam_instance_profile.ecs_instance_profile.id
}
