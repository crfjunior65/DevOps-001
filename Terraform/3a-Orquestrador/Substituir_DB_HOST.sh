#!/bin/bash
cd /home/ec2-user/

# Definindo os caminhos dos arquivos
arquivo_origem="Bia/.env"
arquivo_destino="bia/docker-compose.yml"

# Lendo a informação do arquivo de origem
informacao=$(cat "$arquivo_origem")

# Verificando se a informação foi lida corretamente
if [ -z "$informacao" ]; then
  echo "Erro: Não foi possível ler a informação do arquivo de origem."
  exit 1
fi

# Substituindo a informação no arquivo de destino
#sed -i "s/OLD_TEXT/$informacao/g" "$arquivo_destino"
#sed -i "s/^DB_HOST: .*/DB_HOST: $informacao/" "$arquivo_destino"
sed -i "/DB_HOST:/s/:.*/: $informacao/" "$arquivo_destino"

# Verificando se a substituição foi bem-sucedida
if [ $? -eq 0 ]; then
  echo "Informação substituída com sucesso no arquivo de destino."
else
  echo "Erro: Não foi possível substituir a informação no arquivo de destino."
  exit 1
fi

#PublicIP
# Definindo os caminhos dos arquivos
arquivo_origem="Bia/.PublicIP"
arquivo_destino="bia/Dockerfile"

# Lendo a informação do arquivo de origem
informacao=$(cat "$arquivo_origem")

# Verificando se a informação foi lida corretamente
if [ -z "$informacao" ]; then
  echo "Erro: Não foi possível ler a informação do arquivo de origem."
  exit 1
fi

# Substituindo a informação no arquivo de destino
#sed -i "s/OLD_TEXT/$informacao/g" "$arquivo_destino"
#sed -i "s/^DB_HOST: .*/DB_HOST: $informacao/" "$arquivo_destino"
sed -i "s|http://[^ ]*|http://$informacao:3001|g" "$arquivo_destino"

# Verificando se a substituição foi bem-sucedida
if [ $? -eq 0 ]; then
  echo "Informação substituída com sucesso no arquivo de destino."
else
  echo "Erro: Não foi possível substituir a informação no arquivo de destino."
  exit 1
fi

##############################1
##!/bin/bash
#
## Lê os argumentos de entrada do Terraform
#eval "$(jq -r '@sh "arquivo_origem=\(.arquivo_origem) arquivo_destino=\(.arquivo_destino)"')"
#
## Lê o novo valor para DB_HOST do arquivo de origem
#novo_db_host=$(cat "$arquivo_origem")
#
## Verifica se o valor foi lido corretamente
#if [ -z "$novo_db_host" ]; then
#  echo "Erro: Não foi possível ler o valor de DB_HOST do arquivo de origem." >&2
#  exit 1
#fi
#
## Substitui o valor de DB_HOST no arquivo de destino
#sed -i "/DB_HOST:/s/:.*/: $novo_db_host/" "$arquivo_destino"
#
## Verifica se a substituição foi bem-sucedida
#if [ $? -eq 0 ]; then
#  # Retorna uma saída JSON para o Terraform
#  echo '{"status": "success", "novo_db_host": "'"$novo_db_host"'"}'
#else
#  echo '{"status": "error", "message": "Erro ao substituir DB_HOST"}' >&2
#  exit 1
#fi
#
########### 2
#!/bin/bash
#
## Lê os argumentos de entrada do Terraform
#eval "$(jq -r '@sh "arquivo_origem=\(.arquivo_origem) arquivo_destino=\(.arquivo_destino)"')"
#
## Lê o novo valor para DB_HOST do arquivo de origem
#novo_db_host=$(cat "$arquivo_origem")
#
## Verifica se o valor foi lido corretamente
#if [ -z "$novo_db_host" ]; then
#  echo "Erro: Não foi possível ler o valor de DB_HOST do arquivo de origem."
#  exit 1
#fi
#
## Substitui o valor de DB_HOST no arquivo de destino
#sed -i "/DB_HOST:/s/:.*/: $novo_db_host/" "$arquivo_destino"
#
## Verifica se a substituição foi bem-sucedida
#if [ $? -eq 0 ]; then
#  echo "Valor de DB_HOST substituído com sucesso no arquivo de destino."
#else
#  echo "Erro: Não foi possível substituir o valor de DB_HOST no arquivo de destino."
#  exit 1
#fi
#
##############################1
##!/bin/bash
#
## Lê os argumentos de entrada do Terraform
#eval "$(jq -r '@sh "arquivo_origem=\(.arquivo_origem) arquivo_destino=\(.arquivo_destino)"')"if [ -z "$novo_db_host" ]; then
#  echo "Erro: Não foi possível ler o valor de DB_HOST do arquivo de origem." >&2
#  exit 1
#fi
#
## Substitui o valor de DB_HOST no arquivo de destino
#sed -i "/DB_HOST:/s/:.*/: $novo_db_host/" "$arquivo_destino"
#
## Verifica se a substituição foi bem-sucedida
#if [ $? -eq 0 ]; then
#  # Retorna uma saída JSON para o Terraform
#  echo '{"status": "success", "novo_db_host": "'"$novo_db_host"'"}'
#else
#  echo '{"status": "error", "message": "Erro ao substituir DB_HOST"}' >&2
#  exit 1
#fi
#
########### 2
#!/bin/bash
#
## Lê os argumentos de entrada do Terraform
#eval "$(jq -r '@sh "arquivo_origem=\(.arquivo_origem) arquivo_destino=\(.arquivo_destino)"')"
#
## Lê o novo valor para DB_HOST do arquivo de origem
#novo_db_host=$(cat "$arquivo_origem")
#
## Verifica se o valor foi lido corretamente
#if [ -z "$novo_db_host" ]; then
#  echo "Erro: Não foi possível ler o valor de DB_HOST do arquivo de origem."
#  exit 1
#fi
#
## Substitui o valor de DB_HOST no arquivo de destino
#sed -i "/DB_HOST:/s/:.*/: $novo_db_host/" "$arquivo_destino"
#
## Verifica se a substituição foi bem-sucedida
#if [ $? -eq 0 ]; then
#  echo "Valor de DB_HOST substituído com sucesso no arquivo de destino."
#else
#  echo "Erro: Não foi possível substituir o valor de DB_HOST no arquivo de destino."
#  exit 1
#fi
#
##############################1
#!/bin/bash

# Lê os argumentos de entrada do Terraform
#eval "$(jq -r '@sh "arquivo_origem=\(.arquivo_origem) arquivo_destino=\(.arquivo_destino)"')"# Substitui o valor de DB_HOST no arquivo de destino
#sed -i "/DB_HOST:/s/:.*/: $novo_db_host/" "$arquivo_destino"
#
## Verifica se a substituição foi bem-sucedida
#if [ $? -eq 0 ]; then
#  # Retorna uma saída JSON para o Terraform
#  echo '{"status": "success", "novo_db_host": "'"$novo_db_host"'"}'
#else
#  echo '{"status": "error", "message": "Erro ao substituir DB_HOST"}' >&2
#  exit 1
#fi
#
########### 2
#!/bin/bash

## Lê os argumentos de entrada do Terraform
#eval "$(jq -r '@sh "arquivo_origem=\(.arquivo_origem) arquivo_destino=\(.arquivo_destino)"')"

# Lê o novo valor para DB_HOST do arquivo de origem
#novo_db_host=$(cat "$arquivo_origem")else
#  echo '{"status": "error", "message": "Erro ao substituir DB_HOST"}' >&2
#  exit 1
#fi

########### 2
##!/bin/bash
#
#arquivo_origem="arquivo_origem.txt"
#arquivo_destino="arquivo_destino.yml"
#
#novo_db_host=$(cat "$arquivo_origem")
#
#if [ -z "$novo_db_host" ]; then
#  echo "Erro: Não foi possível ler o valor de DB_HOST do arquivo de origem."
#  exit 1
#fi
#
#sed -i "/DB_HOST:/s/:.*/: $novo_db_host/" "$arquivo_destino"
#
#if [ $? -eq 0 ]; then
#  echo "Valor de DB_HOST substituído com sucesso no arquivo de destino."
#else
#  echo "Erro: Não foi possível substituir o valor de DB_HOST no arquivo de destino."
#  exit 1
#fi
