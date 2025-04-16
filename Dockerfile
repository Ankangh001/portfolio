FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git zip unzip curl libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy Laravel project files
COPY . .

RUN git config --global --add safe.directory /var/www/html && \
    composer install --no-interaction --prefer-dist --optimize-autoloader
    
# Install Composer manually
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Install Laravel dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80