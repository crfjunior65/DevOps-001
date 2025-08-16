resource "aws_security_group" "default-dynamic-block" {
  name        = "defalt-dynamic-block-sg"
  description = "SG de Acesso Default(HTTP,HTTPS,SSH,PostGres), com dynamic-block"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  dynamic "ingress" {
    for_each = var.default_ingress
    content {
      description = ingress.value["description"]
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.default_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "Acesso Defaul-DynamicBlock"
  }
}

resource "aws_security_group" "bia-dev" {
  name        = "dynamic-block-bia-dev-sg"
  description = "SG de Acesso Bia-dev, com dynamic-block"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  dynamic "ingress" {
    for_each = var.bia-dev
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.default_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "Acesso Bia-Dev DynamicBlock"
  }
}

resource "aws_security_group" "windows-sg" {
  name        = "dynamic-block-windows-sg"
  description = "SG de Acesso Instancia Windows, com dynamic-block"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id
  depends_on  = [aws_security_group.bia-dev]
  dynamic "ingress" {
    for_each = var.windows-sg
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      # cidr_blocks agora é opcional
      cidr_blocks = lookup(ingress.value, "cidr_blocks", [])
      # Mapeia as strings para os IDs dos recursos
      security_groups = [
        for sg_name in lookup(ingress.value, "security_groups", []) : local.source_sgs[sg_name]
      ]
      ## cidr_blocks agora é opcional
      #cidr_blocks = ingress.value["cidr_blocks"]
      ## security_groups é opcional
      #security_groups = lookup(ingress.value, "security_groups", [])
    }
  }
  dynamic "egress" {
    for_each = var.default_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "Acesso Instancia Windows DynamicBlock"
  }
}

resource "aws_security_group" "bia-ec2" {
  name        = "dynamic-block-bia-ec2-sg"
  description = "SG de Acesso Bia-ec2, com dynamic-block"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id
  # Dependência explícita
  depends_on = [
    aws_security_group.bia-alb,
    aws_security_group.bia-dev
    # Adicione aqui todos os SGs que esta regra referencia
  ]
  dynamic "ingress" {
    for_each = var.bia-ec2
    content {
      description     = ingress.value["description"]
      from_port       = ingress.value["from_port"]
      to_port         = ingress.value["to_port"]
      protocol        = ingress.value["protocol"]
      security_groups = ingress.value["security_groups"]
      #cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.default_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "Acesso Bia-Ec2 DynamicBlock"
  }
}

resource "aws_security_group" "bia-db" {
  name        = "dynamic-block-bia-db-sg"
  description = "SG de Acesso Bia-Db, com dynamic-block"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  # Adiciona uma dependência explícita
  # Isso garante que estes recursos serão criados antes de "bia-db"
  depends_on = [
    aws_security_group.bia-web,
    aws_security_group.bia-ec2,
    aws_security_group.bia-dev-mssql,
    aws_security_group.bia-build,
    aws_security_group.bia-dev
  ]

  dynamic "ingress" {
    for_each = var.bia-db
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      # CORREÇÃO: Mapeia as strings para os IDs dos recursos
      security_groups = [
        for sg_name in ingress.value.security_groups : local.source_sgs[sg_name]
      ]
      #security_groups = ingress.value["security_groups"]
      # CORREÇÃO: Mapeia as strings para os IDs dos recursos aqui
      # security_groups = [
      #   for sg_name in ingress.value.security_groups : aws_security_group[sg_name].id
      # ]
      #cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.default_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "Acesso Bia-DB DynamicBlock"
  }
}

resource "aws_security_group" "bia-build" {
  name        = "dynamic-block-bia-build-sg"
  description = "SG de Acesso Bia-Build, com dynamic-block"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  dynamic "ingress" {
    for_each = var.bia-build
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      #security_groups = ingress.value["security_groups"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.default_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "Acesso Bia-Build DynamicBlock"
  }
}

resource "aws_security_group" "bia-web" {
  name        = "dynamic-block-bia-web-sg"
  description = "SG de Acesso Bia-Web, com dynamic-block"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  dynamic "ingress" {
    for_each = var.bia-web
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      #security_groups = ingress.value["security_groups"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.default_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "Acesso Bia-Build DynamicBlock"
  }
}

resource "aws_security_group" "bia-dev-mssql" {
  name        = "dynamic-block-bia-dev-mssql-sg"
  description = "SG de Acesso Bia-Dev-MSSQL, com dynamic-block"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  dynamic "ingress" {
    for_each = var.bia-dev-mssql
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      #security_groups = ingress.value["security_groups"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.default_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "Acesso Bia-Dev-MSSQL DynamicBlock"
  }
}

resource "aws_security_group" "bia-alb" {
  name        = "dynamic-block-bia-alb-sg"
  description = "SG de Acesso Bia-Alb, com dynamic-block"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  dynamic "ingress" {
    for_each = var.bia-alb
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      #security_groups = ingress.value["security_groups"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.default_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "Acesso Bia-Alb DynamicBlock"
  }
}








/*
# Security Group para aplicação dev
resource "aws_security_group" "bia-dev" {
  name        = "bia-dev-${var.environment}"
  description = "Libera porta 3001 e SSH"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  # Dynamic block para as regras de ingress
  dynamic "ingress" {
    for_each = var.Dev-Bia_ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  # Dynamic block para as regras padrão de egress
  dynamic "egress" {
    for_each = var.security_group_rules["default_egress"]
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }

  tags = {
    Name = "Acesso_HTTP Porta 3001"
  }
}

# Security Group para MSSQL
resource "aws_security_group" "bia-dev-mssql" {
  name        = "bia-dev-mssql"
  description = "Libera porta 1433 e SSH"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  dynamic "ingress" {
    for_each = [
      {
        from_port       = 1433
        to_port         = 1433
        protocol        = "tcp"
        cidr_blocks     = []
        security_groups = [aws_security_group.bia-dev.id]
        description     = "Acesso MSSQL"
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Acesso SSH"
      }
    ]
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = lookup(ingress.value, "security_groups", null)
      description     = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.security_group_rules["default_egress"]
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "Acesso_MS_SQL Porta 1433"
  }
}
*/