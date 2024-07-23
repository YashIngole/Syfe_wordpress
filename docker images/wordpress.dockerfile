FROM wordpress:php8.1-apache

# Install additional PHP extensions if needed
RUN docker-php-ext-install pdo pdo_mysql

# Copy custom wp-config.php if needed
# COPY wp-config.php /var/www/html/wp-config.php

# Set permissions
RUN chown -R www-data:www-data /var/www/html