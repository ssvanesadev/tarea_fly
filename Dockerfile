FROM php:8.2-apache

# Desactivar MPMs que no deben usarse con PHP
RUN a2dismod mpm_event mpm_worker \
 && a2enmod mpm_prefork

# Instalar extensiones necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Activar mod_rewrite (por si lo necesitas luego)
RUN a2enmod rewrite

# Copiar el código al directorio público de Apache
COPY . /var/www/html/

# Copiar init.sql
COPY sql/init.sql /sql/init.sql

# Permisos (Railway no suele dar problemas, pero es buena práctica)
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
