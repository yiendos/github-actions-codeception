FROM yiendos/nginx:local

ARG DEBIAN_FRONTEND=noninteractive
ENV DOCKER 1

ENV MYSQL_HOST "192.168.0.1"
ENV MYSQL_USER "joomla"
ENV MYSQL_PWD  "joomla"
ENV MYSQL_DB   "sites_testing"

# Necessary to install application
COPY docker/scripts/example-bootstrap.sh /usr/local/bin/bootstrap.sh
COPY docker/scripts/install-database.sh /usr/local/bin/install-database.sh
COPY docker/mysql/joomla_beta_users.sql /tmp/joomla_beta_users.sql

RUN chmod +x /usr/local/bin/bootstrap.sh \
 && chmod +x /usr/local/bin/install-database.sh

WORKDIR /var/www/testing

RUN ["/usr/local/bin/bootstrap.sh"]

RUN chown www-data:www-data /var/www/testing -R

EXPOSE 8081

CMD ["/usr/bin/supervisord"]