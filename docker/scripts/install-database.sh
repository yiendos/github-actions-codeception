#!/bin/bash

set -e

echo "* Waiting 10 seconds for database"
sleep 10

export PATH=/root/.composer/vendor/bin/:$PATH >> ~/.bashrc

#if [ ! -e "/var/www/testing/_installation" ]; then

  echo "* Install site and db"

  echo "* copy existing site from /tmp to web root"

  cp -R /tmp/testing/* /var/www/html/

  echo "* Install database"

  joomla database:install html --mysql-host=db --mysql-login=joomla:joomla --sql-dumps=/tmp/testing/installation/sql/mysql/base.sql --sql-dumps=/tmp/testing/installation/sql/mysql/extensions.sql --sql-dumps=/tmp/testing/installation/sql/mysql/supports.sql --sql-dumps=/tmp/joomla_beta_users.sql --drop;
#fi;

if [ ! -e "/var/www/html/configuration.php" ]; then

  echo "* Configure site"

  joomla site:configure html --mysql-host=db --mysql-login=joomla:joomla --options=/tmp/config.yml;

fi;

echo "* Reset web root permissions"

chown -R www-data:www-data /var/www/html

