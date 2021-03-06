#!/bin/bash
mv /var/www/html/install /var/www/html/installed
echo "Running prestashop install..."
runuser -g www-data -u www-data -- php -d memory_limit=-1 /var/www/html/install/index_cli.php \
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
rm -r /var/www/html/installed \
mv /var/www/html/admin /var/www/html/${PS_FOLDER_ADMIN}
mv /tmp/phppsinfo.php /var/www/html
git config --global user.email "quentin.come4@gmail.com"
git config --global user.name "Quentin"
git init
git commit -am "init"
git push --set-upstream git@gitlab.com:qcome-prestashop/$1.git master
apachectl -D FOREGROUND
#&& git init \
#&& git commit -am "init" \
