#!/bin/bash
echo "Inside 'run_install_prestashop.sh' with parameter: $1"
if [ -z "$1" ]; then
    echo "Boolean parameter for install missing"; 
else
    if [ $1 = true ] ; then
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
            --db_create=${PS_DB_CREATE}
        rm -r /var/www/html/install
        mv /var/www/html/admin /var/www/html/${PS_FOLDER_ADMIN}
        mv /tmp/phppsinfo.php /var/www/html
        # 
        # chmod 600 /root/.ssh/id_rsa
        # git config --global user.email "quentin.come4@gmail.com"
        # git config --global user.name "Quentin"
        # cd /var/www/html
        # git init
        # git add .
        # git commit -m "init"
        # git push --set-upstream git@gitlab.com:qcome-prestashop/$1.git master
    fi
fi
# cd /var/www/html
# chmod 600 /root/.ssh/id_rsa
# git config --global user.email "quentin.come4@gmail.com"
# git config --global user.name "Quentin"
# git init
# git add .
# git commit -m "init"
# git push --set-upstream git@gitlab.com:qcome-prestashop/$1.git master
php-fpm --allow-to-run-as-root
#&& git init \
#&& git commit -am "init" \
