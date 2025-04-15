FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/start-mariadb.sh /usr/local/bin/start-mariadb.sh
RUN chmod +x /usr/local/bin/start-mariadb.sh

CMD ["/usr/local/bin/start-mariadb.sh"]
