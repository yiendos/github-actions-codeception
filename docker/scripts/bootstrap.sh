#!/bin/bash

set -e

rm -Rf /var/www/testing

export PATH=/root/.composer/vendor/bin/:$PATH >> ~/.bashrc

echo "Download site"
joomla site:download testing

echo "Install site and db"

joomla site:install testing --mysql-host=db --mysql-port=3306 --mysql-login=joomla:joomla --drop
