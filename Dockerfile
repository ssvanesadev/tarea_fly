FROM php:8.2-cli

# Instalar extensiones necesarias para MySQL
RUN docker-php-ext-install pdo pdo_mysql

# Copiar la app
COPY . /var/www/html
WORKDIR /var/www/html

# Exponer puerto 80
EXPOSE 80

# Arrancar PHP con su servidor embebido
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html", "-d", "display_errors=1"]
