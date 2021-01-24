FROM mysql:5
ADD scripts/init-db.sh /docker-entrypoint-initdb.d/

RUN chown -R mysql:mysql /docker-entrypoint-initdb.d/