FROM alpine:3.14.0

RUN apk add --update --no-cache \
        stunnel
 
COPY stunnel.conf /etc/stunnel/stunnel-base.conf
COPY entrypoint /usr/local/bin

ENTRYPOINT ["entrypoint"]

CMD ["stunnel"]
