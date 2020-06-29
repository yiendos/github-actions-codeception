#!/bin/bash

set -e

echo "Install site and db"

sleep 10

export PATH=/root/.composer/vendor/bin/:$PATH >> ~/.bashrc

cp -RP /tmp/testing/* /var/www/testing/

joomla database:install testing --mysql-host=db --mysql-login=joomla:joomla --sql-dumps=/var/www/testing/installation/sql/mysql/base.sql --sql-dumps=/var/www/testing/installation/sql/mysql/extensions.sql --sql-dumps=/var/www/testing/installation/sql/mysql/supports.sql --sql-dumps=/tmp/joomla_beta_users.sql --drop;

joomla site:configure testing --mysql-host=db --mysql-login=joomla:joomla;

#probably safe to delete this is the point of supervisord
tail -f /dev/null