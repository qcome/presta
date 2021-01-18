#!/bin/bash
if [ -z "$1" ]; then
    echo "Nom de l'app manquant"; 
else
    # Conf variables transmises au docker-compose
    app_name=$1
    app_folder=sites/$app_name
    ps_version=1.7.7.1
    

    export APP_NAME=$app_name

    if [ ! -d sites/$app_name ]; then

        if [ ! -f archives/prestashop_$ps_version.zip ]; then
            mkdir -p archives
            curl -fsSL https://github.com/PrestaShop/PrestaShop/releases/download/$ps_version/prestashop_$ps_version.zip -o archives/prestashop_$ps_version.zip
        fi

        unzip -n -q archives/prestashop_$ps_version.zip -d $app_folder

        unzip -n -q $app_folder/prestashop.zip
        rm -rf $app_folder/prestashop.zip
    
        #chown www-data:www-data -R $folder/prestashop/
        #cp -n -R -p $folder/prestashop/* /var/www/html

    fi


    


    #cp -R template/. sites/$1/
    #docker-compose down
    #docker-compose up --build
fi