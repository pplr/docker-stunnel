FROM alpine:3.15.2

RUN apk add --update --no-cache \
        stunnel
 
COPY stunnel.conf /etc/stunnel/stunnel-base.conf
COPY entrypoint /usr/local/bin

ENTRYPOINT ["entrypoint"]

CMD ["stunnel"]
