FROM php:8.4-fpm

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install system dependencies
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libxml2-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    zlib1g-dev \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install zip gd pdo_mysql mbstring xml curl

# Create Laravel project
WORKDIR /app
RUN composer create-project laravel/laravel movie-reservation

# COpy current application source code
COPY . /app

# Copy env file to the container
COPY .env /app/movie-reservation/.env

# Set working directory to the Laravel project
WORKDIR /app    

# Install PostgreSQL client
RUN apt-get update && apt-get install -y postgresql-client

# Install Node.js dependencies
RUN npm install

# Run the build command
RUN npm run build

# Expose PHP-FPM port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]