#Data Pasta Orquestraor
/*
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=al2023-ami-*-x86_64" \
  --query 'sort_by(Images, &CreationDate)[-5:][].[ImageId,Name,CreationDate]' \
  --output table

  aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=al2023-ami-2023*1-x86_64" \
  --query 'sort_by(Images, &CreationDate)[-5:][].[ImageId,Name,CreationDate]' \
  --output table
*/
# Dados IAMIs - aws ec2 describe-images --owners amazon |grep noble-24.04 |grep Name

# Recupera a AMI mais recente do Windows Server 2022
data "aws_ami" "windows_server_2022" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "amazon_linux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    #al2023-ami-2023.7.20250414.0-kernel-6.1-x86_64
    #"amzn2-ami-hvm-*-x86_64-gp2"]
    #Amazon Linux 2 Kernel 5.10 AMI 2.0.20250414.0 x86_64 HVM gp2
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Dono das AMIs (Amazon)
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
    #al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"] # Dono das AMIs (Amazon)
}

data "aws_ami" "amazon_linux_2023_sa-1" {
  most_recent = true
  provider    = aws.sa-1
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
    #al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"] # Dono das AMIs (Amazon)
}

#ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-20240605.1
data "aws_ami" "ubuntu_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Dono das AMIs (Amazon)
}

data "aws_ami" "ubuntu_linux_2204" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Dono das AMIs (Amazon)
}


data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "vpc/terraform.tfstate"
    #key    = "RemoteState/vpc/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "sg/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
/*
data "terraform_remote_state" "efs" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "efs/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
*/
data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "iam/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "rds" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "rds/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

/*
data "local_file" "public_key" {
  filename = "~/.ssh/aws-key-terraform.pub"
}
*/



/*
data "template_file" "install_zabbix_server" {
  template = file("install_zabbix_server.sh.tpl")

  vars = {
    ZABBIX_DB_USER   = "zabbix"                                                   #var.zabbix.services.db_user
    ZABBIX_DB_PASS   = "zabbix123456"                                             #var.zabbix.services.db_pass
    ZABBIX_DB_SERVER = "${data.terraform_remote_state.rds.outputs.db_db_address}" #aws_db_instance.banco_zabbix.address
    ZABBIX_DB_NAME   = "zabbix"
  }
}
*/
