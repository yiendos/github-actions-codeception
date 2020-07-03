FROM plain/nginx:local

# Necessary to install application
COPY docker/scripts/example-bootstrap.sh /usr/local/bin/bootstrap.sh
COPY docker/scripts/install-database.sh /usr/local/bin/install-database.sh
COPY docker/mysql/joomla_beta_users.sql /tmp/joomla_beta_users.sql
COPY docker/application/config.yml /tmp/config.yml

RUN chmod +x /usr/local/bin/bootstrap.sh \
 && chmod +x /usr/local/bin/install-database.sh

WORKDIR /var/www/html