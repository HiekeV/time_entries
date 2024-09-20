FROM php:8.0-fpm-alpine

# Install necessary packages and PHP extensions
RUN apk add --no-cache nginx wget \
    && docker-php-ext-install pdo pdo_mysql  # Install PDO and PDO MySQL extensions

    
# Create directories for Nginx
RUN mkdir -p /run/nginx

# Copy Nginx configuration
COPY docker/nginx.conf /etc/nginx/nginx.conf

# Create application directory and copy files
RUN mkdir -p /app
COPY . /app
COPY ./src /app

# Install Composer
RUN sh -c "wget http://getcomposer.org/composer.phar && chmod a+x composer.phar && mv composer.phar /usr/local/bin/composer"
RUN cd /app && \
    /usr/local/bin/composer install --no-dev

# Set permissions
RUN chown -R www-data: /app

# Make the startup and migration scripts executable
RUN chmod +x /app/docker/startup.sh /app/db-migration.sh

# Start script for Nginx and PHP-FPM
ENTRYPOINT ["/app/entrypoint.sh"]