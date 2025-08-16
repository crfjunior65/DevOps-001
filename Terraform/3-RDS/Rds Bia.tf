resource "aws_db_instance" "db-Projeto" {
  allocated_storage   = 20
  db_name             = var.environment
  engine              = "postgres"
  engine_version      = "16.3"
  instance_class      = "db.t3.micro"
  deletion_protection = false
  identifier          = var.environment
  multi_az            = false
  username            = "postgres" # O nome de usuário não pode ser alterado após a criação para algumas engines.
  password            = random_password.db_master_password.result
  #parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true
  #5432 PostGres
  depends_on = [aws_secretsmanager_secret.db_password_secret]
  #Selecionar VPC

  #vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  #Selecionar SubRede
  #subnet_id = module.vpc.private_subnets
  db_subnet_group_name = data.terraform_remote_state.vpc.outputs.vpc_db_subnet_grp_name
  #db_subnet_group_name   = module.vpc.database_subnets

  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_bia_db]

  #vpc.outputs.sg_rds_id]
  #    aws_security_group.acesso-rds.id]


  tags = {
    "Environment" = "Projeto_${var.environment}"
    "Management"  = "Terraform"
    "Name"        = "db-${var.environment}"
    "Terraform"   = "true"
  }

  lifecycle {
    ignore_changes = [password]
  }
}

/*
  links:
      - database
    environment:
      DB_USER: postgres
      DB_PWD: postgres
      DB_HOST: database
      DB_PORT: 5432
      ## NAO PRECISA NO BOOTCAMP DAQUI PRA BAIXO ##
      # DB_SECRET_NAME:
      # DB_REGION:
      # AWS_ACCESS_KEY_ID:
      # AWS_SECRET_ACCESS_KEY:
      # DEBUG_SECRET:
      # IS_LOCAL: true
    # healthcheck:
    #   test: ["CMD", "curl", "-f", "http://localhost:8080/api/versao"]
    #   interval: 10s
    #   timeout: 5s
    #   retries: 3
    #   start_period: 5s
  database:
    image: postgres:16.1
    container_name: database
    environment:
      - "POSTGRES_USER=postgres"
      - "POSTGRES_PASSWORD=postgres"
      - "POSTGRES_DB=bia"
    ports:
      - 5433:5432
    volumes:
      - db:/var/lib/postgresql/data
volumes:


*/
