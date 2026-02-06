# Usamos PHP-FPM oficial
FROM php:8.2-fpm

# Instalar extensiones PHP y Nginx + Supervisor
RUN docker-php-ext-install pdo pdo_mysql \
    && apt-get update && apt-get install -y nginx supervisor \
    && rm -rf /var/lib/apt/lists/*

# Copiar configuración de Nginx y Supervisor
COPY nginx.conf /etc/nginx/sites-enabled/default
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copiar código de la aplicación
COPY . /var/www/html/

# Ajustar permisos
RUN chown -R www-data:www-data /var/www/html/

# Exponer puerto 80
EXPOSE 80

# Comando para arrancar Supervisor (PHP-FPM + Nginx)
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
