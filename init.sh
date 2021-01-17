#!/bin/bash
apt-get -y update

export HOSTNAME=$(curl -s http://169.254.169.254/metadata/v1/hostname)
export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
echo Droplet: $HOSTNAME, IP Address: $PUBLIC_IPV4 > /usr/share/nginx/html/index.html

curl -fsSL https://get.docker.com -o get-docker.sh
bash install_docker.sh
sudo usermod -aG docker root

docker network create prestashop-net
docker run -ti --name some-mysql --network prestashop-net -e MYSQL_ROOT_PASSWORD=admin -e MYSQL_DATABASE=prestashop -p 3307:3306 -d mysql:5.7
docker run --name some-prestashop --network prestashop-net -v `pwd -W`:/var/www/html:rw \
-e DB_SERVER=some-mysql \
-e DB_USER=root \
-e DB_PASSWD=admin \
-e DB_NAME=prestashop \
-e ADMIN_MAIL=demo@prestashop.com \
-e ADMIN_PASSWD=prestashop_demo \
-e PS_INSTALL_AUTO=1 \
-e PS_FOLDER_ADMIN=adminPS \
-e PS_DOMAIN=localhost:8080 \
-e PS_DEV_MODE=1 \
-p 8080:80 prestashop/prestashop