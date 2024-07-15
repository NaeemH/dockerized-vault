# Generate keys & certs for prod/dev server
## Generate CA private key
```bash
openssl genrsa -out ca.key 2048
```
## Create CA CSSR
```bash
openssl req -new -key ca.key -out ca.csr -config openssl.cnf
```
## Create ca.pem via self-signed CA certificate
```bash
openssl x509 -req -in ca.csr -out ca.pem -signkey ca.key -days 365 -extensions v3_ca -extfile openssl.cnf
```
## Validate self-signed cert
```bash
openssl x509 -in ca.pem -text -noout
```
## Generate certificate.pem & key.pem
```bash
openssl req -x509 -nodes -newkey rsa:2048 -keyout key.pem -out certificate.pem -config openssl.cnf -extensions req_ext -days 365
```
