resource "aws_instance" "ec2_amz2023" {
  ami           = data.terraform_remote_state.Orquestrador.outputs.ami_linux_amz_2023
  instance_type = "t3.micro"

  # Configuração do volume raiz (EBS)
  root_block_device {
    volume_size = 8     # Tamanho em GiB (padrão: 8GB para muitas AMIs)
    volume_type = "gp3" # Tipo de volume (gp2, gp3, io1, etc.)
    encrypted   = true  # Garante que o volume seja criptografado
    #delete_on_termination = true
    #snapshot_id = null
  }

  key_name                    = data.terraform_remote_state.Orquestrador.outputs.key_name
  availability_zone           = data.terraform_remote_state.vpc.outputs.vpc_azs_id[0]
  subnet_id                   = data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[0]
  associate_public_ip_address = true

  #user_data            = file("InstallDev.sh")
  iam_instance_profile = data.terraform_remote_state.iam.outputs.iam_ssm_profile.id

  tags = {
    Name        = "Ec2-AmzLinux-2023"
    Terraform   = "true"
    AZ          = data.terraform_remote_state.vpc.outputs.vpc_azs_id[0]
    Environment = "Projeto"
    Management  = "Terraform"
  }

  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_bia_dev]
}
