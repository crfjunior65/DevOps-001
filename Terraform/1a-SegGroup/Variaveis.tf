variable "AWS_REGION" {
  description = "AWS Region where resources will be created"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Ambiente de deploy (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
  default     = ""
}

variable "security_groups" {
  description = "Mapa de security groups a serem criados"
  type = map(object({
    description = string
    ingress_rules = list(object({
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      security_groups = list(string)
      description     = string
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    tags = map(string)
  }))
  default = {}
}

#LucasXX

###############################
# Variáveis para grupos de segurança
# Dev-Bia, Alb-Bia, Ec2-Bia
# Essas variáveis definem as regras de entrada (ingress) para os grupos de segurança
# Dev-Bia: Grupo de segurança para o ambiente de desenvolvimento Bia
# Alb-Bia: Grupo de segurança para o Application Load Balancer Bia
# Ec2-Bia: Grupo de segurança para as instâncias EC2 Bia
# Cada grupo de segurança possui regras de entrada definidas por portas, protocolos e CIDR blocks
# As regras de entrada são definidas como um mapa de objetos, onde cada objeto contém:
# - description: Descrição da regra de segurança
# - cidr_blocks: Lista de blocos CIDR permitidos
# - from_port: Porta de origem permitida
# - to_port: Porta de destino permitida
# - protocol: Protocolo utilizado (tcp, udp, etc.)
# Essas variáveis são utilizadas para configurar os grupos de segurança no Terraform  alerting.

variable "default_ingress" {
  type = map(object({ description = string, cidr_blocks = list(string) }))
  default = {
    22   = { description = "Inbound para SSH", cidr_blocks = ["0.0.0.0/0"] }
    3001 = { description = "Inbound para HTTP", cidr_blocks = ["0.0.0.0/0"] }
    80   = { description = "Inbound para HTTP", cidr_blocks = ["0.0.0.0/0"] }
    443  = { description = "Inbound para HTTPS", cidr_blocks = ["0.0.0.0/0"] }
    5432 = { description = "Inbound para postgres", cidr_blocks = ["0.0.0.0/0"] }
  }
}

variable "default_egress" {
  type = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string) }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

/*
variable "bia-dev" {
  type = map(object({ description = string, cidr_blocks = list(string) }))
  default = {
    3001 = { description = "Acesso HTTP na porta 3001", cidr_blocks = ["0.0.0.0/0"] }
    22   = { description = "Acesso SSH", cidr_blocks = ["0.0.0.0/0"] }
  }
}
*/
variable "bia-dev" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = {
    # Exemplo 1: Porta Única
    http = {
      description = "Acesso HTTP 3001"
      from_port   = 3001
      to_port     = 3001
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # Exemplo 2: Porta Única
    ssh = {
      description = "Acesso SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "bia-alb" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = {
    # Exemplo 1: Porta Única
    http = {
      description = "Acesso HTTP 80"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # Exemplo 2: Porta Única
    https = {
      description = "Acesso HTTPS 443"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "bia-dev-mssql" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = {
    # Exemplo 1: Porta Única
    mssql = {
      description = "Acesso MSSql 1433"
      from_port   = 1443
      to_port     = 1443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # Exemplo 2: Porta Única
    ssh = {
      description = "Acesso SSH 22"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "bia-web" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = {
    # Exemplo 1: Porta Única
    https = {
      description = "Acesso HTTPS 433"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # Exemplo 2: Porta Única
    http = {
      description = "Acesso SHTTP 80"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "bia-build" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = {
    # Exemplo 1: Porta Única
    https = {
      description = "Acesso HTTPS 433"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "bia-db" {
  type = map(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    security_groups = list(string)
  }))

  default = {
    # Exemplo 1: Porta Única
    postgres = {
      description = "Acesso PostGres Porta 5432"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      # CORREÇÃO: Mapeia as strings para os IDs dos recursos aqui
      # security_groups = [
      #   for sg_name in ingress.value.security_groups : aws_security_group[sg_name].id
      # ]
      security_groups = [
        "bia-web",
        "bia-ec2",
        "bia-dev-mssql",
        "bia-build",
        "bia-dev"
      ]
    }
    # Exemplo 2: Porta Única
    mssql = {
      description = "Acesso MSSQL Porta 1433"
      from_port   = 1433
      to_port     = 1433
      protocol    = "tcp"
      security_groups = [
        #aws_security_group.bia-web.id,
        #aws_security_group.bia-ec2.id,
        "bia-dev",
        "bia-dev-mssql"
      ]
    }
  }
}

variable "bia-ec2" {
  type = map(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    security_groups = list(string)
  }))

  default = {
    # Exemplo 1: Porta Única
    full = {
      description     = "Acesso Full"
      from_port       = 0
      to_port         = 65535
      protocol        = "tcp"
      security_groups = ["bia-alb"]
    }
    # Exemplo 2: Porta Única
    ssh = {
      description     = "Acesso SSH"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      security_groups = ["bia-dev"]
    }
  }
}

# Cria um security group para permitir RDP e HTTP/HTTPS
variable "windows-sg" {
  type = map(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), []) # cidr_blocks agora é opcional
    security_groups = optional(list(string), []) # security_groups é opcional
  }))

  default = {
    # Exemplo 1: Porta Única
    rdp = {
      description = "Acesso RDP"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      security_groups = [
        "bia-dev"
      ]
    }
    # Exemplo 2: Porta Única
    http = {
      description = "Acesso HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    https = {
      description = "Acesso HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

