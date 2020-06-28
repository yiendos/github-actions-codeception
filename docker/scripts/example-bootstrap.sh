#!/bin/bash

set -e

export PATH=/root/.composer/vendor/bin/:$PATH >> ~/.bashrc

echo "Download site"

joomla site:download testing --release=4.0.0-beta

rm -rf /var/www/testing/administrator/templates/atum/css; rm -rf /var/www/testing/templates/cassiopeia/css; rm -rf /var/www/testing/media/; rm -rf /var/www/testing/node_modules/; rm -rf /var/www/testing/libraries/vendor/;rm -f /var/www/testing/administrator/cache/autoload_psr4.php; rm -rf /var/www/testing/installation/template/css;

composer install --working-dir=/var/www/testing/ --ignore-platform-reqs; npm ci --prefix /var/www/testing/ --unsafe-perm;