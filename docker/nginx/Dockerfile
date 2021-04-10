FROM nginx:apline

COPY ./wait-for-it.sh /tmp/
COPY ./docker_entrypoint.sh ./

RUN chmod +x /tmp/wait-for-it.sh ./docker_entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["nginx" "-g" "daemon off;"]
