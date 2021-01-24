FROM mysql:5
ADD scripts/init-db.sh /docker-entrypoint-initdb.d/

RUN chown -R mysql:mysql /docker-entrypoint-initdb.d/
RUN chown -R mysql:mysql /usr/local/bin/docker-entrypoint.sh/

CMD ["mysqld", "--character-set-server=utf8mb4", "--collation-server=utf8mb4_unicode_ci"]