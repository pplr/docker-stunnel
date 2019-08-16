FROM alpine:3.10.1 AS certs
RUN set -x \
 && apk add --update --no-cache gnutls-utils
WORKDIR /certs
COPY gen-certs.sh .
RUN sh gen-certs.sh   

FROM alpine:3.10.1

RUN apk add --update --no-cache \
        stunnel
 
COPY --from=certs /certs/x509-server-key.pem /certs/x509-server.pem /etc/stunnel/
COPY stunnel.conf /etc/stunnel/stunnel.conf

EXPOSE 587

CMD ["stunnel"]
