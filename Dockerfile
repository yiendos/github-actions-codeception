FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
ENV DOCKER 1
ENV ENVIRONMENT "development"

ENV MYSQL_HOST "192.168.0.1"
ENV MYSQL_USER "joomla"
ENV MYSQL_PWD  "joomla"
ENV MYSQL_DB   "sites_testing"

ENV PHP_OPCACHE_ENABLE "on"
ENV PHP_DISPLAY_ERRORS "off"
ENV PHP_ERROR_REPORTING "4983"

# Install packages
RUN apt-get update \
 && apt install curl git unzip -y \
 && apt-get install -y software-properties-common  \
 && curl -s https://packagecloud.io/install/repositories/timble/web/script.deb.sh | bash \
 && apt-add-repository ppa:ondrej/php \
 && apt-get update \
 && apt-get install -y supervisor \
    nginx \
    php7.3-fpm php-apcu php7.3-curl php7.3-gd php-imagick php7.3-intl php7.3-json php7.3-mbstring php-mongodb php7.3-mysql php-oauth php-sodium php7.3-tidy php7.3-xml php-yaml php7.3-zip \
    mysql-client \
 && apt-get remove -y gnupg software-properties-common gnupg apt-transport-https \
 && apt-get -y autoremove \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /usr/src/linux-headers*

# Create required directories and set file permissions
RUN mkdir -p /var/run/php

# Install the application
COPY docker/scripts/bootstrap.sh /usr/local/bin/bootstrap.sh
COPY docker/nginx/demo.conf /etc/nginx/sites-available/default
COPY docker/php/override.conf /etc/php/7.3/fpm/pool.d/override.conf
COPY docker/php/fpm.conf /etc/php/7.3/fpm/php-fpm.conf
COPY docker/supervisord /etc/supervisor/conf.d/

RUN curl -sS https://getcomposer.org/installer -o /root/composer-setup.php && \
    php /root/composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    echo 'PATH=/root/.composer/vendor/bin/:$PATH' >> ~/.bashrc  && \
    composer global require joomlatools/console --no-interaction

#RUN chmod +x /usr/local/bin/bootstrap.sh

EXPOSE 8081

WORKDIR /var/www/

CMD ["/usr/bin/supervisord"]