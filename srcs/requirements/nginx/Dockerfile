FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

COPY conf/nginx.conf /etc/nginx/nginx.conf
#COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY tools/start_nginx.sh /usr/local/bin/start_nginx.sh
#COPY tools/generate_cert.sh /usr/local/bin/generate_cert.sh

#RUN chmod +x /usr/local/bin/generate_cert.sh
#RUN /usr/local/bin/generate_cert.sh

RUN chmod +x /usr/local/bin/start_nginx.sh

EXPOSE 443

CMD ["/usr/local/bin/start_nginx.sh"]
