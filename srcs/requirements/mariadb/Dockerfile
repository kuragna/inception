FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Create directory for MariaDB data
RUN mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql

# Copy MariaDB configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy initialization script
COPY tools/db_init.sh /usr/local/bin/db_init.sh
RUN chmod +x /usr/local/bin/db_init.sh

EXPOSE 3306

CMD ["/usr/local/bin/db_init.sh"]
