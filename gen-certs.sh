set -euo pipefail

# Generate CA

certtool --generate-privkey > x509-ca-key.pem
echo 'cn = Dummy CA'            >  ca.tmpl
echo 'ca'                       >> ca.tmpl
echo 'cert_signing_key'         >> ca.tmpl
echo 'expiration_days = 365000' >> ca.tmpl
certtool --generate-self-signed --load-privkey x509-ca-key.pem \
--template ca.tmpl --outfile x509-ca.pem

# Generate server cert
certtool --generate-privkey > x509-server-key.pem
echo 'organization = stunnel server'   >  server.tmpl
echo 'cn = stunnel'                    >> server.tmpl
echo 'encryption_key'                  >> server.tmpl
echo 'signing_key'                     >> server.tmpl
echo 'expiration_days = 365000'        >> server.tmpl
echo 'dns_name = "stunnel"'            >> server.tmpl
certtool --generate-certificate --load-privkey x509-server-key.pem \
--load-ca-certificate x509-ca.pem --load-ca-privkey x509-ca-key.pem \
--template server.tmpl --outfile x509-server.pem