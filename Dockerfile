# Base PHP CLI
FROM php:8.2-cli

# Instalar extensiones necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Copiar aplicación
COPY . /var/www/html
WORKDIR /var/www/html

# Ajustar permisos
RUN chown -R www-data:www-data /var/www/html

# Exponer puerto 80
EXPOSE 80

# Arrancar servidor embebido de PHP
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html", "-d", "display_errors=1"]
