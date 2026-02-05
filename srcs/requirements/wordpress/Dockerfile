FROM debian:bookworm

# installer les paquets necessaires
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    php8.2-fpm \
    php-mysql \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html/wordpress

WORKDIR /var/www/html

# telecharger et decompresser WordPress
RUN wget https://fr.wordpress.org/latest-fr_FR.zip && \
    unzip latest-fr_FR.zip && \
    rm latest-fr_FR.zip

# Ajuster les permissions
RUN chown -R www-data:www-data /var/www/html/wordpress && \
    chmod -R 755 /var/www/html/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Configurer PHP-FPM pour écouter sur le port 9000
RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf

# script de demarrage
COPY tools/start_wp.sh /usr/local/bin/start_wp.sh
RUN chmod +x /usr/local/bin/start_wp.sh

EXPOSE 9000

CMD ["/usr/local/bin/start_wp.sh"]