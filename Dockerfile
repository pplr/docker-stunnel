FROM alpine:3.10.1 AS certs
RUN set -x \
 && apk add --update --no-cache gnutls-utils
WORKDIR /certs
COPY gen-certs.sh .
RUN sh gen-certs.sh   

FROM alpine:3.10.1

RUN apk add --update --no-cache \
        stunnel
 
COPY --from=certs x509-ca.pem x509-server-key.pem x509-server.pem /etc/stunnel/
COPY --from=certs stunnel.conf /etc/stunnel/stunnel.conf

EXPOSE 587

CMD ["stunnel"]
