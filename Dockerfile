FROM ubuntu:18.04
# Install.
RUN \
sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
apt-get update && \
apt-get -y upgrade && \
apt-get install -y build-essential && \
apt-get install -y software-properties-common && \
apt-get install -y byobu curl git htop man unzip vim wget && \
rm -rf /var/lib/apt/lists/*
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y apache2 libapache2-mod-php
RUN apt install -y php unzip
RUN apt-get install -y php-cli php-common php-mbstring php-gd php-intl php-xml php-mysql php-zip php-curl php-xmlrpc
COPY ./apache-config.conf /etc/apache2/sites-available/000-default.conf
ARG APP_NAME
#RUN echo ${APP_NAME}
COPY --chown=www-data:www-data ./sites/${APP_NAME}/ /var/www/html/
RUN ls /var/www/html/

RUN cd /var/www/html/install && php index_cli.php \
--domain=${PS_DOMAIN} \
--db_server=${MYSQL_SERVER} \
--db_name=${MYSQL_DATABASE} \
--db_user=${MYSQL_USER} \
--db_password=${MYSQL_PASSWORD} \
--email=${PS_ADMIN_EMAIL} \
--password=${PS_ADMIN_PASSWORD} \
--language=${PS_LANGUAGE} \
--country=${PS_COUNTRY}
RUN a2enmod rewrite
# Define working directory.
WORKDIR /var/www/html
# Define default command.
EXPOSE 80
CMD apachectl -D FOREGROUND