#! /bin/bash 


# Instalacao Terrafor 
echo "# Instalacao Terraform, Iniciada..." >>/home/ec2-user/AndamentoUserData.Terraform
mkdir /home/ec2-user/Install
echo "Executamos USER DATA" >/home/ec2-user/Install/UserData
# mkdir /home/ec2-user/IaC
mkdir /home/ec2-user/Projeto
mkdir /home/ec2-user/Projeto/Docker
mkdir /home/ec2-user/Projeto/Terraform
cd /home/ec2-user
mkdir Data
chown -R ec2-user:ec2-user *

cd /home/ec2-user/Install
yum update -y
yum upgrade -y
yum install htop wget unzip -y

#Instalação PostGres 
echo "Executando Instalacao PostGre SQL 15..." >/home/ec2-user/Install/UserData
yum install postgresql15 -y     # postgresql-server postgresql-contrib -y

# Recursos EFS
#https://github.com/aws/efs-utils?tab=readme-ov-file#on-other-linux-distributions
#yum update -y
yum install nfs-common -y
yum -y install binutils 
#rustc cargo pkg-config libssl-dev
yum install -y amazon-efs-utils

TER_VER=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1')
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
unzip terraform_${TER_VER}_linux_amd64.zip
mv terraform /usr/bin/
echo "# Instalacao Terraform, Terminada" >>/home/ec2-user/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ec2-user/AndamentoUserData.Terraform

#wget -O- https://yum.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
#echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://yum.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/yum/sources.list.d/hashicorp.list
#sudo yum update && sudo yum install terraform

echo "Executamos USER DATA" >>/home/ec2-user/Install/UserData

# Instalacao CLI AWS
echo "# Instalacao AWS Cli, Iniciada..." >>/home/ec2-user/AndamentoUserData.Terraform
cd /home/ec2-user/Install

# Amazon Linux - AWS CLI
yum install awscli

# https://www.youtube.com/watch?v=PLG--ieltJE
echo "# Instalacao AWS Cli, Terminada" >>/home/ec2-user/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ec2-user/AndamentoUserData.Terraform

# Acesso SSM
echo "# Instalacao AWS SSM, Iniciada..." >>/home/ec2-user/AndamentoUserData.Terraform
mkdir /tmp/ssm
cd /tmp/ssm
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl status amazon-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# Utilitarios
yum install net-tools -y

chown -R ec2-user:ec2-user /home/ec2-user/*
echo "# Instalacao AWS SSM, Terminada" >>/home/ec2-user/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ec2-user/AndamentoUserData.Terraform

# Copiando Chaves de Acesso
#cd /home/ec2-user/IaC/
#aws s3 cp s3://crfjunior/Projeto20/IaC/aws-key .

# Acesso GIT
echo "# Instalacao GIT, Iniciada..." >>/home/ec2-user/AndamentoUserData.Terraform
#Instalar Docker e Git
#sudo yum update -y
sudo yum install git -y
sudo yum install docker -y
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker ssm-user
id ec2-user ssm-user
sudo newgrp docker

#Ativar docker
sudo systemctl enable docker.service
sudo systemctl start docker.service

#Instalar docker compose 2
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose


echo "# Instalacao GIT, Terminada" >>/home/ec2-user/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ec2-user/AndamentoUserData.Terraform

#Adicionar swap
sudo dd if=/dev/zero of=/swapfile bs=128M count=32
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

cd /home/ec2-user/Projeto/Terraform
cd /home/ec2-user/Projeto/Docker
cd /home/ec2-user
git clone https://github.com/henrylle/exemplo-secrets.git
git clone https://github.com/henrylle/lab-especial-aurora-formacao.git
git clone https://github.com/henrylle/bia
cd /home/ec2-user/bia
cp scripts/ecs/unix/*.sh .
chmod +x *.sh

#Instalar Cliente MySQL
#yum install mariadb -y

#Instalar node e npm
curl -fsSL https://rpm.nodesource.com/setup_21.x | sudo bash -
sudo yum install -y nodejs

#git clone https://github.com/henrylle/bia

cd /home/ec2-user/bia
echo 'DB_HOST: ${data.terraform_remote_state.rds.outputs.db_db_address}' >> .env
docker compose -d up
docker compose exec server bash -c 'npx sequelize db:migrate'

# 1. Instalar dependências (jq para processar JSON da AWS CLI)
sudo yum install -y jq 

# 2. Coletar o Endpoint do Banco de Dados (ex: RDS)
DB_ENDPOINT=$(aws rds describe-db-instances \
  --query 'DBInstances[?DBInstanceIdentifier==`bia`].Endpoint.Address' \
  --output text)

# 3. Coletar o IP público do NAT Gateway
NAT_GATEWAY_ID=$(aws ec2 describe-nat-gateways \
  --filter Name=tag:Name,Values=Formacao_AWS-vpc-us-east-1a \
  --query 'NatGateways[0].NatGatewayId' \
  --output text)

NAT_GATEWAY_IP=$(aws ec2 describe-nat-gateways \
  --nat-gateway-ids "$NAT_GATEWAY_ID" \
  --query 'NatGateways[0].NatGatewayAddresses[0].PublicIp' \
  --output text)

# 4. Criar arquivo com os dados coletados
echo $DB_ENDPOINT > /home/ec2-user/DadosColetados.txt
echo $NAT_GATEWAY_IP >> /home/ec2-user/DadosColetados.txt
echo "---------------------------------" >>/home/ec2-user/AndamentoUserData.Terraform
echo "Criando Arquivo com Dados Coletados..." >>/home/ec2-user/AndamentoUserData.Terraform

cat <<EOF > /home/ec2-user/infra_info.txt
Database Endpoint: $DB_ENDPOINT
NAT Gateway Public IP: $NAT_GATEWAY_IP
EOF

# 5. Ajustar permissões do arquivo
chown ec2-user:ec2-user /home/ec2-user/infra_info.txt
chmod 600 /home/ec2-user/infra_info.tx
echo "---------------------------------" >>/home/ec2-user/AndamentoUserData.Terraform
echo "Finalizando UserData." >>/home/ec2-user/AndamentoUserData.Terraform
chown -R ec2-user:ec2-user *