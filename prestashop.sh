#!/bin/bash
if [ -z "$1" ]; then
    echo "Nom de l'app manquant"; 
else
    # Conf variables transmises au docker-compose
    app_name=$1
    root_folder=sites/$app_name
    app_folder=$root_folder/app
    ps_version=1.7.7.1
    run_install=false
    #apt install -y php unzip

    # Si nouvelle app on extrait l'archive dans le rep et on delete les fichiers inutiles, hop hop hop
    if [ ! -d sites/$app_name ]; then
        run_install=true

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
        
        cp ./docker/php-fpm/.gitignore $app_folder

        chown www-data:www-data -R $app_folder/
    fi

    docker-compose -f ./docker/docker-compose.yml down
    APP_NAME=$app_name RUN_INSTALL=$run_install docker-compose -f ./docker/docker-compose.yml up --build
fi