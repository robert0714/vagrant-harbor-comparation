# vagrant-harbor
Usage
========================

<br/>
ansible-playbook  /vagrant/ansible/harbot.yml  -i /vagrant/ansible/hosts/sit
<br/>
https://github.com/vmware/harbor
<br/>
# SSL
https://github.com/vmware/harbor/blob/master/docs/configure_https.md
<br/>
https://github.com/vmware/harbor/blob/master/docs/installation_guide.md


<br/>
Thank you, that also worked for me. Equivalent steps on Ubuntu/Debian:

Copy CA cert to /usr/local/share/ca-certificates.

sudo update-ca-certificates

sudo service docker restart


There is still a bug here, though. The docs say to install the CA cert in /etc/docker/certs.d/<registry>, and clearly that isn't sufficient. In fact, after installing the certificate globally, I removed the one in /etc/docker/certs.d, restarted Docker, and it still worked.

<br>

 openssl req     -newkey rsa:4096 -nodes -sha256 -keyout ca.key  \
    -x509 -days 365 -out ca.crt     -reqexts SAN   \
      -config <(cat /etc/ssl/openssl.cnf \
   <(printf "\n[SAN]\nsubjectAltName=DNS:example.com,DNS:www.example.com,IP:192.168.57.44")) 



 openssl req \
    -newkey rsa:4096 -nodes -sha256 -keyout 192.168.57.44.key \
    -out 192.168.57.48.csr


    echo subjectAltName = IP:192.168.57.48 > extfile.cnf

    openssl x509 -req -days 365 -in yourdomain.com.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out yourdomain.com.crt

    openssl x509 -req -days 365 -in 192.168.57.48.csr -CA ca.crt -CAkey ca.key -CAcreateserial -extfile extfile.cnf -out 192.168.57.48.crt

Usage Introduction
====
https://github.com/vmware/harbor/blob/master/docs/user_guide.md
可以參考https://wiki.centos.org/zh-tw/HowTos/Https

extfile.cnf
===
```
basicConstraints=CA:FALSE
nsCertType  = client, server, email
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection
nsComment = "OpenSSL Generated Certificate"
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid,issuer
subjectAltName = IP:192.168.57.44,IP:192.168.57.45,IP:192.168.57.46,IP:192.168.57.47,IP:127.0.0.1,IP:10.100.98.20
```

step1
<br/>
```
  openssl req \
    -newkey rsa:4096 -nodes -sha256 -keyout ca.key \
    -x509 -days 3650 -out ca.crt
```

step2
<br/>
```
  $ openssl req     -newkey rsa:4096 -nodes -sha256 -keyout harbor_cert.key  \
  -out   harbor_cert.csr

```
step3
<br/>
```
$ openssl x509 -req -days 3650 -in  harbor_cert.csr \
-CA ca.crt -CAkey ca.key -CAcreateserial -extfile extfile.cnf -out  harbor_cert.crt

```
