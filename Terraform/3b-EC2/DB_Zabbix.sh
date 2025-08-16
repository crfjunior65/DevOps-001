#!/bin/bash

ZABBIX_DB_SERVER="dbzabbix.cvimy8y2y6zu.us-east-1.rds.amazonaws.com"
echo $ZABBIX_DB_SERVER
ZABBIX_DB_USER="zabbix"
ZABBIX_DB_PASS="zabbix123456"
ZABBIX_DB_NAME="zabbix"
mysql -h${ZABBIX_DB_SERVER} -u${ZABBIX_DB_USER} -p${ZABBIX_DB_PASS} -e "create user '${ZABBIX_DB_USER}'@'${ZABBIX_DB_SERVER}' identified by '${ZABBIX_DB_PASS}'"
mysql -h${ZABBIX_DB_SERVER} -u${ZABBIX_DB_USER} -p${ZABBIX_DB_PASS} -e "grant all privileges on ${ZABBIX_DB_USER}.* to '${ZABBIX_DB_NAME}'@'${ZABBIX_DB_SERVER}'"
mysql -h${ZABBIX_DB_SERVER} -u${ZABBIX_DB_USER} -p${ZABBIX_DB_PASS} -e "set global log_bin_trust_function_creators = 1"