FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

# on met le server block ici
COPY conf/default.conf /etc/nginx/conf.d/default.conf

COPY tools/start_nginx.sh /usr/local/bin/start_nginx.sh
RUN chmod +x /usr/local/bin/start_nginx.sh

EXPOSE 443

CMD ["/usr/local/bin/start_nginx.sh"]
