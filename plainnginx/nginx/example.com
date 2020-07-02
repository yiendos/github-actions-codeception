server {
        listen       *:8081;

        server_name  .*;

        access_log  /var/log/nginx/access.log combined;
        error_log   /var/log/nginx/error.log;

        root /var/www/html;
        index index.php index.html index.htm index.nginx-debian.html;

        location / {
                try_files $uri $uri/ =404;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}