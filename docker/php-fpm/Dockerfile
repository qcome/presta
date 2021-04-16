FROM php:7.3-fpm

RUN apt-get update \
	&& apt-get install -y libmcrypt-dev \
		libjpeg62-turbo-dev \
		libpcre3-dev \
		libpng-dev \
		libfreetype6-dev \
		libxml2-dev \
		libicu-dev \
		libzip-dev \
		default-mysql-client \
		wget \
		unzip \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install iconv intl pdo_mysql mbstring soap gd zip mysqli \
	&& docker-php-ext-enable mysqli

RUN docker-php-source extract \
  && if [ -d "/usr/src/php/ext/mysql" ]; then docker-php-ext-install mysqlnd; fi \
  && if [ -d "/usr/src/php/ext/mcrypt" ]; then docker-php-ext-install mcrypt; fi \
  && if [ -d "/usr/src/php/ext/opcache" ]; then docker-php-ext-install opcache; fi \
  && docker-php-source delete

COPY ./apache-config.conf /etc/apache2/sites-available/000-default.conf
COPY ./wait-for-it.sh /tmp/
COPY ./docker_entrypoint.sh /tmp/
COPY ./run_install_prestashop.sh /tmp/
COPY ./phppsinfo.php /tmp/
COPY ./php.ini /usr/local/etc/php/

RUN if [ -x "$(command -v apache2-foreground)" ]; then a2enmod rewrite; fi
#COPY --chown=www-data:www-data ${APP_LOCATION}/ /var/www/html/
COPY --chown=www-data:www-data ${APP_LOCATION}/ /var/www/html/

RUN chmod +x /tmp/wait-for-it.sh /tmp/docker_entrypoint.sh /tmp/run_install_prestashop.sh

ENTRYPOINT ["/tmp/docker_entrypoint.sh"]
CMD ["/tmp/run_install_prestashop.sh", "$RUN_INSTALL"]
# Define working directory.
WORKDIR /var/www/html
# Define default command.
EXPOSE 80


