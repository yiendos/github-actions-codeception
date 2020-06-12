FROM yiendos/nginx_php

# Install the application
COPY docker/scripts/example-bootstrap.sh /usr/local/bin/bootstrap.sh

RUN chmod +x /usr/local/bin/bootstrap.sh

EXPOSE 8081

WORKDIR /var/www/

CMD ["/usr/bin/supervisord"]