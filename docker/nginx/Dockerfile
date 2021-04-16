FROM nginx:latest

COPY ./wait-for-it.sh /tmp/
COPY ./docker-entrypoint.sh ./

RUN chmod +x /tmp/wait-for-it.sh ./docker-entrypoint.sh

RUN echo "LS -L"
RUN ls -l

#ENTRYPOINT ["./docker-entrypoint.sh"]

CMD nginx
