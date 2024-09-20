#!/bin/sh

sed -i "s,LISTEN_PORT,$PORT,g" /etc/nginx/nginx.conf

php-fpm -D

# Wait for PHP-FPM to be ready
while ! nc -z 127.0.0.1 9000; do sleep 1; done

nginx -g "daemon off;" &

# Wait for Nginx to start
while ! nc -z 127.0.0.1 80; do sleep 1; done

# Signal that the application is ready
touch /tmp/app_ready