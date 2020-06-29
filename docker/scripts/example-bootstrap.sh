#!/bin/bash

set -e

export PATH=/root/.composer/vendor/bin/:$PATH >> ~/.bashrc

echo "Download site"

joomla site:download testing --release=4.0.0-beta --www=/tmp

chown -R www-data:www-data /tmp/testing

rm -rf /tmp/testing/administrator/templates/atum/css; rm -rf /tmp/testing/templates/cassiopeia/css; rm -rf /tmp/testing/media/; rm -rf /tmp/testing/node_modules/; rm -rf /tmp/testing/libraries/vendor/;rm -f /tmp/testing/administrator/cache/autoload_psr4.php; rm -rf /tmp/testing/installation/template/css;

composer install --working-dir=/tmp/testing/ --ignore-platform-reqs; npm ci --prefix /tmp/testing/ --unsafe-perm;

mkdir -p /var/www/testing