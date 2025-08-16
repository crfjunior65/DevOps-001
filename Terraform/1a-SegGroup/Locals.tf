locals {
  source_sgs = {
    "bia-web"       = aws_security_group.bia-web.id
    "bia-ec2"       = aws_security_group.bia-ec2.id
    "bia-dev-mssql" = aws_security_group.bia-dev-mssql.id
    "bia-build"     = aws_security_group.bia-build.id
    "bia-dev"       = aws_security_group.bia-dev.id
    "bia-alb"       = aws_security_group.bia-alb.id
    #"windows-sg"    = aws_security_group.windows-sg.id
  }
}