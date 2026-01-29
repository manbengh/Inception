FROM debian:bookworm

# Installer les paquets nécessaires
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    php-fpm \
    php-mysql \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

# Télécharger et décompresser WordPress
RUN wget https://fr.wordpress.org/latest-fr_FR.zip && \
    unzip latest-fr_FR.zip && \
    rm latest-fr_FR.zip && \
    mv wordpress/* . && \
    rmdir wordpress

# Script de démarrage
COPY tools/start_wp.sh /usr/local/bin/start_wp.sh
RUN chmod +x /usr/local/bin/start_wp.sh

EXPOSE 9000

CMD ["/usr/local/bin/start_wp.sh"]

