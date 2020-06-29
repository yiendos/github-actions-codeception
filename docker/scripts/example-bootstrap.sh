#!/bin/bash

set -e

export PATH=/root/.composer/vendor/bin/:$PATH >> ~/.bashrc

echo "Download site"

joomla site:download testing --release=4.0.0-beta --www=/tmp

echo "* remove some existing files"

rm -rf /tmp/testing/administrator/templates/atum/css; rm -rf /tmp/testing/templates/cassiopeia/css; rm -rf /tmp/testing/media/; rm -rf /tmp/testing/node_modules/; rm -rf /tmp/testing/libraries/vendor/;rm -f /tmp/testing/administrator/cache/autoload_psr4.php; rm -rf /tmp/testing/installation/template/css;

echo "* install dependancies and run npm"

composer install --working-dir=/tmp/testing/ --ignore-platform-reqs; npm ci --prefix /tmp/testing/ --unsafe-perm;

echo "* finally create site root, before nginx started"

mkdir -p /var/www/testing