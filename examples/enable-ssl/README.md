#### enable-ssl

This example demonstrates how to extend the postgresql container by enabling SSL/TLS.  

The following instructions assumes the use of OpenShift.  

1. Deploy postgres:  
```bash
oc new-app --name psql-ssl postgresql:13-el7~https://github.com/sclorg/postgresql-container.git \
  --context-dir examples/enable-ssl \
  -e POSTGRESQL_USER=myUser \
  -e POSTGRESQL_PASSWORD=myPassword \
  -e POSTGRESQL_DATABASE=myDB
```

2. Create your secrets:  
```bash
openssl genrsa -out tls.key 2048
openssl req -new -x509 -key tls.key -out tls.cert
oc create secret tls db-ssl-keys --key tls.key --cert tls.cert
```

3. Bind your secrets into postgres deploymentConfig:  
```bash
oc set volume --add \
    --type=secret \
    --secret-name=db-ssl-keys \
    --default-mode=0640 \
    --mount-path=/opt/app-root/src/certs/ \
    dc/psql-ssl
```

