resource "aws_iam_instance_profile" "role_acesso_ssm" {
    name        = "role-acesso-ssm"
    name_prefix = null
    path        = "/"
    role        = aws_iam_role.role_acesso_ssm.name
    tags        = {}
    tags_all    = {}
}

resource "aws_iam_role" "role_acesso_ssm" {
    assume_role_policy    = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}"
    description           = "Allows EC2 instances to call AWS services like CloudWatch and Systems Manager on your behalf."
    force_detach_policies = false
    #managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess", "arn:aws:iam::aws:policy/AmazonECS_FullAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
    max_session_duration  = 3600
    name                  = "role-acesso-ssm"
    name_prefix           = null
    path                  = "/"
    permissions_boundary  = null
    tags                  = {}
    tags_all              = {}
}

resource "aws_iam_role_policy_attachment" "role_acesso_ssm_policy_ecr" {
  role       = aws_iam_role.role_acesso_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
resource "aws_iam_role_policy_attachment" "role_acesso_ssm_policy_ecs" {
  role       = aws_iam_role.role_acesso_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}
resource "aws_iam_role_policy_attachment" "role_acesso_ssm_policy_s3" {
  role       = aws_iam_role.role_acesso_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
resource "aws_iam_role_policy_attachment" "role_acesso_ssm_policy_ssm" {
  role       = aws_iam_role.role_acesso_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "role_acesso_ssm_policy" {
  role       = aws_iam_role.role_acesso_ssm.name
  policy_arn = aws_iam_policy.get_secret_bia_db.arn
}
