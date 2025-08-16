resource "aws_instance" "ec2_bastianhost" {
  depends_on = [aws_key_pair.deployer]

  # A AMI é obtida através de um data source, o que é uma boa prática.
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.micro"

  # Configuração do volume raiz (EBS)
  root_block_device {
    volume_size           = 15    # Tamanho em GiB (padrão: 8GB para muitas AMIs)
    volume_type           = "gp3" # Tipo de volume (gp2, gp3, io1, etc.)
    encrypted             = true  # Garante que o volume seja criptografado
    delete_on_termination = true
  }

  key_name = var.key_name

  availability_zone = data.terraform_remote_state.vpc.outputs.vpc_azs_id[0]
  subnet_id         = data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[0]

  associate_public_ip_address = true

  # O script user_data é a maneira recomendada de configurar uma instância no boot.
  # A lógica que estava nos provisioners deve ser movida para este ou um script similar.
  user_data = file("InstallDev.sh")

  iam_instance_profile = data.terraform_remote_state.iam.outputs.iam_ssm_profile.id

  tags = {
    Name        = "BastionHost"
    Terraform   = "true"
    AZ          = data.terraform_remote_state.vpc.outputs.vpc_azs_id[0]
    Environment = "Projeto"
    Management  = "Terraform"
  }
  # Sintaxe moderna para listas, sem a interpolação "${...}"
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_bia_dev]
}
