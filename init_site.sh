#!/bin/bash
if [ -z "$1" ]; 
    then echo "Nom de l'app manquant"; 
else
    # Conf variables transmises au docker-compose
    export APP_NAME=$1
    export READ_ONLY_VOLUME=false

    docker-compose down
    docker-compose up --build
fi