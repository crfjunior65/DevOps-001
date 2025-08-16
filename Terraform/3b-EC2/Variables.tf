variable "amis" {
  type = map(any)
  default = {
    "Ubnt-us-east-1" = "ami-0261755bbcb8c4a84"
    "Ubnt-us-east-2" = "ami-0430580de6244e02e"
  }

}

variable "cdirs_acesso_remoto" {
  type    = list(any)
  default = ["187.180.212.28/32", "200.181.118.98/32"]
}

variable "key_name" {
  type    = string
  default = "aws-key-terraform" ######"KeyPar-072024"

}

variable "dynamic_scaling" {
  description = "Enable/disable dynamic scaling of the auto scaling group."
  type        = bool
  default     = false
}

variable "dynamic_scaling_adjustment" {
  description = "The adjustment in number of instances for dynamic scaling."
  type        = number
  default     = 1
}

variable "environment" {
  description = "Name of the environment; will be prefixed to all resources."
  type        = string
  default     = "Projeto"
}

variable "app_count" {
  type    = number
  default = 2
}

variable "user_names" {
  description = "Name of the User."
  type        = list(string)
  default     = ["XXX", "YYY", "ZZZ"]
}

###

#variable "projeto" {
#  type        = string
#  description = "Descrição do projeto."
#}

#variable "cliente" {
#  type        = string
#  description = "Cliente do projeto."
#}

#variable "autor" {
#  type        = string
#  description = "Autor de edição."
#}

#variable "shortnameid" {
#  type        = string
#  description = "Nome curto para identificação dos recursos na AWS"
#}

#variable "regiao" {
#  type        = string
#  description = "Região onde a infraestrutura será criada."
#}

#variable "remote-state-bucket" {
#  type        = string
#  description = "Bucket name onde está o remote state"
#}


variable "regiao" {
  type        = string
  description = "Região onde a infraestrutura será criada."
}


variable "projeto" {
  description = "Descrição do projeto."
  type        = string
}

variable "cliente" {
  description = "Cliente do projeto."
  type        = string
}

variable "autor" {
  description = "Autor de edição."
  type        = string
}

variable "shortnameid" {
  description = "Nome curto para identificação dos recursos na AWS"
  type        = string
}
/*
      ZABBIX_DB_SERVER="dbzabbix.cvimy8y2y6zu.us-east-1.rds.amazonaws.com"
      ZABBIX_DB_USER="zabbix"
      ZABBIX_DB_PASS="zabbix123456"
      ZABBIX_DB_NAME="zabbixdb"


#ZABBIX_DB_SERVER
variable "zabbix_db_server" {
  type    = string
  default = data.terraform_remote_state.rds.outputs.db_db_address
}

#ZABBIX_DB_USER
variable "zabbix_db_user" {
  type    = string
  default = data.terraform_remote_state.rds.outputs.db_db_username
}

#ZABBIX_DB_PASS
variable "zabbix_db_pass" {
  type    = string
  default = data.terraform_remote_state.rds.outputs.db_db_password
}

#ZABBIX_DB_NAME
variable "zabbix_db_name" {
  type    = string
  default = data.terraform_remote_state.rds.outputs.db_db_name
}

*/
