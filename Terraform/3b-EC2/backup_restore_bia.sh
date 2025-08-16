#!/bin/bash

HOST_ORIGEM=SEU_HOST_RDS
HOST_DESTINO=SEU_HOST_AURORA_SERVERLESS
USER_ORIGEM=SEU_USER_RDS
USER_DESTINO=SEU_USER_SERVERLESS
if [ "$#" -ne 2 ]; then
    echo "Erro: O script requer exatamente 2 argumentos."
    echo "DB_Origem: $HOST_ORIGEM:$USER_ORIGEM"
    echo "DB_Destino: $HOST_DESTINO:$USER_DESTINO"
    echo "Uso: $0 <Password_DB_Origem> <Password_DB_Destino>"
    exit 1
fi
PASSWORD_ORIGEM=$1
PASSWORD_DESTINO=$2
DATABASE=SEU_BANCO
FILE=dump_bia.tar

echo "Gerando Aruivo pgPassword..."
if [ ! -f ".pgpass" ]; then
    touch .pgpass
    echo "$HOST_ORIGEM:5432:$DATABASE:$USER_ORIGEM:$PASSWORD_ORIGEM" > .pgpass

    echo "$HOST_DESTINO:5432:$DATABASE:$USER_DESTINO:$PASSWORD_DESTINO" >> .pgpass
    echo "$HOST_DESTINO:5432:postgres:$USER_DESTINO:$PASSWORD_DESTINO" >> .pgpass

    chmod 0600 .pgpass
fi


echo 'Testando conexao com banco de origem'
PGPASSFILE=.pgpass pg_isready -d $DATABASE -h $HOST_ORIGEM -p 5432 -U $USER_ORIGEM

echo 'Iniciando backup'
PGPASSFILE=.pgpass pg_dump -U $USER_ORIGEM -h $HOST_ORIGEM -d $DATABASE --clean --no-privileges --no-owner --verbose --file $FILE
echo '-----------------------------------------------------------------------'
echo 'Backup finalizado'


echo 'Testando conexao com banco de destino'
PGPASSFILE=.pgpass pg_isready -d $DATABASE -h $HOST_DESTINO -p 5432 -U $USER_DESTINO
# Verifica o código de retorno
RETORNO=$?
if [ "$RETORNO" -eq 0 ]; then
    echo "Conexão bem-sucedida!"
elif [ "$RETORNO" -eq 1 ]; then
    echo "Erro: Falha na conexão com o banco de destino."
    sleep 30
    PGPASSFILE=.pgpass pg_isready -d $DATABASE -h $HOST_DESTINO -p 5432 -U $USER_DESTINO
    #exit 1
elif [ "$RETORNO" -eq 2 ]; then
    echo "Erro: Não foi possível se conectar ao servidor PostgreSQL."
    sleep 30
    PGPASSFILE=.pgpass pg_isready -d $DATABASE -h $HOST_DESTINO -p 5432 -U $USER_DESTINO
    #exit 1
else
    echo "Erro desconhecido. Código de retorno: $RETORNO"
    exit 1
fi

echo 'Fechando conexoes com detino'
PGPASSFILE=.pgpass psql -d postgres -h $HOST_DESTINO -p 5432 -U $USER_DESTINO -q -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DATABASE'"

echo 'Drop banco destino'
PGPASSFILE=.pgpass dropdb -U postgres -h $HOST_DESTINO $DATABASE

echo 'Create banco destino'
PGPASSFILE=.pgpass createdb -U postgres -h $HOST_DESTINO $DATABASE

echo 'Executando restore'
PGPASSFILE=.pgpass psql -d $DATABASE -h $HOST_DESTINO -p 5432 -U $USER_DESTINO -e -f $FILE

echo 'RESTORE FINALIZADO. PARABENS!!!'

echo 'Limpando arquivos...'
if [ -f ".pgpass" ]; then
    rm -rf .pgpass
fi