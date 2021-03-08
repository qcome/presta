#!/bin/bash
if [ -z "$1" ]; then
    echo "Nom de l'app manquant"; 
else
    # Conf variables transmises au docker-compose
    app_name=$1
    root_folder=sites/$app_name
    app_folder=$root_folder/app
    ps_version=1.7.7.1
    app_already_installed=true
    #apt install -y php unzip

    # Si nouvelle app
    if [ ! -d sites/$app_name ]; then

        app_already_installed = false
        echo "$app_already_installed"
        # Si l'archive n'est pas présente on la DL
        if [ ! -f archives/prestashop_$ps_version.zip ]; then
            mkdir -p archives
            curl -fsSL https://github.com/PrestaShop/PrestaShop/releases/download/$ps_version/prestashop_$ps_version.zip -o archives/prestashop_$ps_version.zip
        fi

        # Création rep site
        mkdir -p $app_folder

        # Unzip archive complète
        unzip -n -q archives/prestashop_$ps_version.zip -d $app_folder
        # Delete unecessary files
        rm -rf $app_folder/index.php
        rm -rf $app_folder/Install_PrestaShop.html
        
        # Unzip sous-archive
        unzip -n -q $app_folder/prestashop.zip -d $app_folder
        rm -rf $app_folder/prestashop.zip
        
        cp ./docker/.gitignore $app_folder

        chown www-data:www-data -R $app_folder/
    fi

    echo "$app_already_installed"

    docker-compose down
    APP_NAME=$app_name INSTALLED=$app_already_installed docker-compose up --build
fi