# Define la imagen base de PHP 8.1 con Apache
FROM php:8.1-apache
WORKDIR /app
EXPOSE 80
# Instala las dependencias necesarias
RUN apt-get update && \
    apt-get install -y \
    libpq-dev \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    && docker-php-ext-install pdo pdo_pgsql pgsql mbstring exif pcntl bcmath gd zip

# Copia los archivos de la aplicación al contenedor
COPY . .

# Copia el archivo de configuración del servidor Apache
COPY ./vhost.conf /etc/apache2/sites-available/000-default.conf

# Instala las dependencias de Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Establece los permisos de almacenamiento
RUN chown -R www-data:www-data /app/storage
RUN chmod -R 775 /app/storage

# Habilita el módulo de Apache para reescritura de URL
RUN a2enmod rewrite

# Instala las dependencias de la aplicación
RUN composer install

# Ejecuta el servidor Apache
CMD ["apache2-foreground"]
