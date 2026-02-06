FROM php:8.2-apache

# Extensiones PHP necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Copiar la app
COPY . /var/www/html/

# Ajustar permisos
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80
