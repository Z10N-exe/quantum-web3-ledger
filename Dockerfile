FROM php:8.3-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libcurl4-openssl-dev \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install MongoDB extension
RUN pecl install mongodb && docker-php-ext-enable mongodb

# Copy app code
WORKDIR /var/www/html
COPY . /var/www/html

# Install Composer dependencies
RUN composer install --no-dev --optimize-autoloader

# Apache config
RUN a2enmod rewrite
COPY .htaccess /var/www/html/.htaccess

EXPOSE 80
CMD ["apache2-foreground"]