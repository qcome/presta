#!/bin/bash
if [ -z "$1" ]; 
    then echo "Nom de l'app manquant"; 
else
    export APP_NAME=$1
    export READ_ONLY_VOLUME=true
    cd ./docker-compose
    docker-compose -f docker-compose-init.yml down
    docker-compose -f docker-compose-init.yml up --build
fi