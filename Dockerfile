# Usamos PHP-FPM oficial
FROM php:8.2-fpm

# Instalar extensiones necesarias para MySQL y otras utilidades
RUN docker-php-ext-install pdo pdo_mysql

# Instalar Nginx
RUN apt-get update && apt-get install -y nginx supervisor \
    && rm -rf /var/lib/apt/lists/*

# Copiar configuración de Nginx
COPY nginx.conf /etc/nginx/sites-enabled/default

# Copiar supervisor config para PHP-FPM + Nginx
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copiar código de la aplicación
COPY . /var/www/html/

# Ajustar permisos
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80

# Comando para arrancar supervisord (PHP-FPM + Nginx)
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
