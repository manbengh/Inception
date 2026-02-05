FROM debian:bookworm

RUN apt update && apt install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY tools/start_mariadb.sh /start_mariadb.sh

RUN chmod +x /start_mariadb.sh

EXPOSE 3306

CMD ["/start_mariadb.sh"]

