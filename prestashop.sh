#!/bin/bash
if [ -z "$1" ]; then
    echo "Nom de l'app manquant"; 
else
    # Conf variables transmises au docker-compose
    app_name=$1
    root_folder=sites/$app_name
    app_folder=$root_folder/app
    ps_version=1.7.7.1
    #apt install -y php unzip

    # Si nouvelle app
    if [ ! -d sites/$app_name ]; then

        # Si le l'archine n'est pas présente on la DL
        if [ ! -f archives/prestashop_$ps_version.zip ]; then
            mkdir -p archives
            curl -fsSL https://github.com/PrestaShop/PrestaShop/releases/download/$ps_version/prestashop_$ps_version.zip -o archives/prestashop_$ps_version.zip
        fi

        # Création rep site
        mkdir -p $app_folder

        # Unzip archive complète
        unzip -n -q archives/prestashop_$ps_version.zip -d $app_folder
        rm -rf $app_folder/index.php
        rm -rf $app_folder/Install_PrestaShop.html
        # Unzip sous-archive
        unzip -n -q $app_folder/prestashop.zip -d $app_folder
        rm -rf $app_folder/prestashop.zip

        chown www-data:www-data -R $app_folder/

        # Ajout du docker compose dans le dossier target
        cp docker/docker-compose.yml $root_folder
        cp docker/Dockerfile $root_folder
        cp .env $root_folder
    fi

    docker-compose -f $root_folder/docker-compose.yml down
    APP_NAME=$app_name docker-compose -f $root_folder/docker-compose.yml up --build
fi