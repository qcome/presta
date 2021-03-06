#!/bin/bash
echo "Running prestashop install..." \
&& runuser -g www-data -u www-data -- php -d memory_limit=-1 /var/www/html/installed/index_cli.php \
--domain=${PS_DOMAIN} \
--db_server=${MYSQL_SERVER} \
--db_name=${MYSQL_DATABASE} \
--db_user=${MYSQL_USER} \
--db_password=${MYSQL_PASSWORD} \
--email=${PS_ADMIN_EMAIL} \
--password=${PS_ADMIN_PASSWORD} \
--language=${PS_LANGUAGE} \
--country=${PS_COUNTRY} \
--db_create=${PS_DB_CREATE} \
&& mv /var/www/html/admin /var/www/html/${PS_FOLDER_ADMIN} \
&& mv /tmp/phppsinfo.php /var/www/html \
&& apachectl -D FOREGROUND
#&& git init \
#&& git commit -am "init" \
