FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git zip unzip curl libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip

RUN a2enmod rewrite

WORKDIR /var/www/html

COPY . .

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer install --no-interaction --prefer-dist --optimize-autoloader

EXPOSE 80
