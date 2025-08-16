resource "aws_key_pair" "deployer" {
  key_name   = "aws-key-terraform"
  public_key = local.public_key_file
  #("~/.ssh/aws-key-terraform.pub")
}

resource "aws_key_pair" "deployer_sa-1" {
  provider   = aws.sa-1
  key_name   = "aws-key-terraform_sa-1"
  public_key = local.public_key_file
  #("~/.ssh/aws-key-terraform.pub")
}
