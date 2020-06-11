#!/bin/bash

set -e

echo "Update installable packages"

apt update -y

echo "Install necessary stuff to create a new joomla site"

apt install curl git unzip -y

echo "Now we are going to get composer"
curl -sS https://getcomposer.org/installer -o /root/composer-setup.php

echo "Move to local bin"

php /root/composer-setup.php --install-dir=/usr/local/bin --filename=composer

echo "Make path executable"

export PATH=/root/.composer/vendor/bin/:$PATH >> ~/.bashrc

echo "Composer install joomlatools-console"

composer global require joomlatools/console --no-interaction

echo "Download site"
joomla site:download testing

echo "Install site and db"

joomla site:install testing --mysql-host=db --mysql-port=3306 --mysql-login=joomla:joomla --drop