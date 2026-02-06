# Imagen PHP con Apache limpia
FROM php:8.2-apache-bullseye

# Deshabilitar MPM que pueda generar conflicto y habilitar prefork
RUN a2dismod mpm_event \
    && a2enmod mpm_prefork \
    && docker-php-ext-install pdo pdo_mysql

# Copiar la aplicación PHP
COPY . /var/www/html/

# Ajustar permisos
RUN chown -R www-data:www-data /var/www/html/

# Exponer puerto 80
EXPOSE 80

# Arranque estándar de Apache
CMD ["apache2-foreground"]
