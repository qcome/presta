#!/bin/bash
php index_cli.php 
    --domain=${PS_DOMAIN} 
    --db_server=${MYSQL_SERVER} 
    --db_name=${MYSQL_DATABASE} 
    --db_user=${MYSQL_USER} 
    --db_password=${MYSQL_PASSWORD} 
    --email=${PS_ADMIN_EMAIL} 
    --password=${PS_ADMIN_PASSWORD} 
    --language=${PS_LANGUAGE} 
    --country=${PS_COUNTRY} 
    && apachectl -D FOREGROUND