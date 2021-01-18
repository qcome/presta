#!/bin/bash
if [ -z "$1" ]; then
    echo "Nom de l'app manquant"; 
else
    # Conf variables transmises au docker-compose
    app_name=$1
    ps_version=$ps_version
    folder=sites/$app_name

    export APP_NAME=$app_name

    if [ ! -d sites/$app_name ]; then
        if [ ! -f archives/prestashop_$ps_version.zip ]; then
            curl -fsSL https://github.com/PrestaShop/PrestaShop/releases/download/$ps_version/prestashop_$ps_version.zip -o archives/prestashop/prestashop_$ps_version.zip
        fi
        unzip -d $folder archives/prestashop_$ps_version.zip
    
        # dwl version contains zip file with tree structure (1.7)
        if [ ! -d $folder/prestashop ]; then
            unzip -n -q $folder/prestashop.zip -d $folder/prestashop
            rm -rf $folder/prestashop.zip
        fi

        chown www-data:www-data -R $folder/prestashop/
        cp -n -R -p $folder/prestashop/* /var/www/html
    
    
    fi


    


    #cp -R template/. sites/$1/
    #docker-compose down
    #docker-compose up --build
fi