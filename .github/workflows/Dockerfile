FROM timble/demo:latest AS local

ENV ENVIRONMENT "development"
ENV CAMPAIGNMONITOR_API_KEY "abc"
ENV CAMPAIGNMONITOR_LIST_ID "abc"

ENV MYSQL_HOST "192.168.0.1"
ENV MYSQL_USER "joomla"
ENV MYSQL_PWD  "joomla"
ENV MYSQL_DB   "sites_testing"

# Install the application
COPY ../../docker/scripts /usr/local/bin/
COPY ../../docker/nginx/demo.conf /etc/nginx/sites-available/default
COPY ../../docker/php/override.conf /etc/php/7.3/fpm/pool.d/override.conf

RUN apt update && \
    apt install curl git unzip -y && \
    curl -sS https://getcomposer.org/installer -o /root/composer-setup.php && \
    php /root/composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    echo 'PATH=/root/.composer/vendor/bin/:$PATH' >> ~/.bashrc  && \
    composer global require joomlatools/console --no-interaction

EXPOSE 8081

WORKDIR /var/www/

CMD ["/usr/bin/supervisord"]