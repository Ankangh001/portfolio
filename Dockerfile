# Stage 1: Build composer dependencies
FROM composer:latest AS composer_stage

WORKDIR /app
COPY . /app
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Stage 2: Apache PHP image for Laravel
FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git zip unzip curl libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip

RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy code from previous stage
COPY --from=composer_stage /app /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
