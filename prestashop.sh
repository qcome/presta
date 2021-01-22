#!/bin/bash
if [ -z "$1" ]; then
    echo "Nom de l'app manquant"; 
else
    # Conf variables transmises au docker-compose
    app_name=$1
    app_folder=sites/$app_name
    ps_version=1.7.7.1
    #apt install -y php unzip

    # Si nouvelle app
    if [ ! -d sites/$app_name ]; then

        if [ ! -f archives/prestashop_$ps_version.zip ]; then
            mkdir -p archives
            curl -fsSL https://github.com/PrestaShop/PrestaShop/releases/download/$ps_version/prestashop_$ps_version.zip -o archives/prestashop_$ps_version.zip
        fi

        mkdir -p archives $app_folder
        unzip -n -q archives/prestashop_$ps_version.zip -d $app_folder

        unzip -n -q $app_folder/prestashop.zip -d $app_folder
        rm -rf $app_folder/prestashop.zip

        chown www-data:www-data -R $app_folder/
        #cp -n -R -p $folder/prestashop/* /var/www/html

    fi
    docker-compose down
    APP_LOCATION=./sites/$app_name docker-compose up --build
fi