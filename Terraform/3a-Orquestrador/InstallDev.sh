#! /bin/bash 
echo "Executamos USER DATA" >/home/ec2-user/Install/UserData

# Instalacao Terrafor 
echo "# Instalacao Terraform, Iniciada..." >>/home/ec2-user/AndamentoUserData.Terraform
mkdir /home/ec2-user/Install
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

# Instalacao Apache
echo "# Instalacao Apache, Iniciada..." >>/home/ec2-user/AndamentoUserData.Terraform
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo  "<h1>Welcome : Apache installed with the help of user_data and file function</h1>" | sudo tee /var/www/html/index.html
echo "# Instalacao Apache, Terminada" >>/home/ec2-user/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ec2-user/AndamentoUserData.Terraform

# Instalacao Docker
cd /home/ec2-user/Install
echo "# Instalacao Docker, Iniciada..." >>/home/ec2-user/AndamentoUserData.Terraform
yum update -y
yum search docker
yum info docker
yum install docker -y
usermod -a -G docker ec2-user
newgrp docker
#yum install python3-pip -y
#pip3 install docker-compose
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
chmod -v +x /usr/local/bin/docker-compose

systemctl enable docker.service
systemctl start docker.service

echo "# Instalacao Docker, Terminada" >>/home/ec2-user/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ec2-user/AndamentoUserData.Terraform

# Instalacao CLI AWS
echo "# Instalacao AWS Cli, Iniciada..." >>/home/ec2-user/AndamentoUserData.Terraform
cd /home/ec2-user/Install

# Amazon Linux - AWS CLI
yum install awscli

#yum remove awscli -y
#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#unzip awscliv2.zip
##./aws/install
#./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update

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

# Ubuntu
#yum install awscli -y

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
yum install git -y

echo "# Instalacao GIT, Terminada" >>/home/ec2-user/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ec2-user/AndamentoUserData.Terraform

#Debian
#cd /home/ec2-user/Install
#git clone https://github.com/aws/efs-utils
#git clone https://github.com/aws/efs-utils
#cd efs-utils
#./build-deb.sh
#apt -y install ./build/amazon-efs-utils*deb
#apt-get -y install ./build/amazon-efs-utils*deb


cd /home/ec2-user/Projeto/Terraform
#Usar o Git para faser o Push
#cd /home/ec2-user/Projeto/Terraform/
#git clone https://github.com/crfjunior65/Projeto20G6.git
cd /home/ec2-user/Projeto/Docker
#git clone https://github.com/crfjunior65/Projeto20G6-CICD.git
#cd /home/ec2-user/Projeto/Terraform/
#git clone https://github.com/crfjunior65/Projeto20G6.git
#Usar o Git Para fazer Push
cd /home/ec2-user
git clone https://github.com/henrylle/bia
git clone https://github.com/henrylle/exemplo-secrets.git
#git clone https://github.com/henrylle/lab-especial-aurora-formacao.git
#Instalar Cliente MySQL
#yum install mariadb -y

chown -R ec2-user:ec2-user *