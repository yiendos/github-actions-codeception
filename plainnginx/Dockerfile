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

RUN apt-get update \
 && apt install curl git unzip -y \
 && apt-get install -y software-properties-common  \
 && apt-add-repository ppa:ondrej/php \
 && apt-get update \
 && apt-get install -y supervisor \
    nginx \
    php7.3-fpm php-apcu php7.3-curl php7.3-gd php7.3-cli php-imagick php7.3-intl php7.3-json php7.3-mbstring php-mongodb php7.3-mysql php-oauth php-sodium php7.3-tidy php7.3-xml php-yaml php7.3-zip \
    mysql-client \
    nano

RUN mkdir -p /var/run/php
RUN mkdir -p /var/log/php-fpm

COPY nginx/example.com /etc/nginx/sites-available/default
COPY application/index.php /var/www/html/index.php
COPY supervisord /etc/supervisor/conf.d/

EXPOSE 8081

CMD ["/usr/bin/supervisord"]