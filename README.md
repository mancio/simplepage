# Simplepage

## Description

Docker compose made by 3 apps:
* Nginx server (entry point)
* Nginx server with html page (web content)
* Certbot (certificate creation)

### How to publish the html page nginx container

* if you are using raspberry pi check cpu architecture using
`cat /proc/cpuinfo | grep model`
* on raspberry pi just run 
`docker run --platform=linux/arm/v7 -dp 80:80 your_repository/simplepage:latest`
* if `linux/arm/v7` is not working change it according to your architecture
* on classic pc `docker run -dp 80:80 your_repository/simplepage:latest`
* have fun!

### How to configure Nginx server

Page content server doesn't need configuration because is
not directly exposed.
Differently, the main nginx container require a custom 
nginx.conf file.
You can see in the file these lines:
* `server` code block with one single setup
* `return 301 https://www.manciotech.fun;` used to force the 
    browser to use secure connection (must be off to give to certbot 
    the possibility to certifies your domain using http 80 port)
* `ssl_certificate` and `key` where certificate files are saved bay certbot (remember to 
  make them visible between containers)
* `include` and `ssl_dhparam` important security settings
* `proxy_pass` to redirect connection from the main server to the real web site
* `location ^~ /.well-known` every certificate provider to issue a certificate need to generate 
    a code in a text file inside a specific folder like this `domain/.well-known/{cert-type}/{file}`
    this code is read back after the generation from the provider. This give him the proof of domain
  existence and will generate .crt or .pem files

### Pagekite

Pagekite is a super cool service on this [page](https://pagekite.net) that give you the possibility
to access remotely your device (pc, raspberry, remote VM, ...) without port forwarding in safe way.
This service give you the possibility to make your server public through a link myname.pagekite.me.
Using a raspberry is possible install the service on linux and it will run automaticcaly in background
forwarding the connection with https secure link.

You can find inn the pagekite directory the files for manual configuration.

### First run

1. be sure `return 301 https://www.manciotech.fun;` is commented (to give the possibility 
   to certbot to access port 80)
2. execute `docker-compose up`
3. stop execution with ctrl+c
4. uncomment `return 301 https://www.manciotech.fun;` (force a secure connection)
5. execute `docker-compose up`

### Procedure for Zerossl

Certbot is a pain in the ass?... did you remember to use `--dry-run` option? 
Well, maybe is too late to issue new certificates (certbot has a limit).

My suggestion id to ask for 90 days free certificate on ZeroSSL.

Steps:
1. Make an account
2. Start the verification process using HTTP File Upload
3. Give access to the folder `/.well-known/pki-validation/` to make it visible from your domain
   like `mydomain.com/.well-known/pki-validation/`
4. Save the TXT file in this space accessible by docker container and try to reach it like 
   suggested by ZeroSSL
5. If the test pass, download the certificate files, connect with cat, like the site say 
   (eventually change file name and then change again to `certificate.crt`)
6. Save the these files in the server and control in `nginx.conf` they can be reached both using
   http 80 and https 443 ssl connection.
   
### Troubleshooting

Sometimes happen certbot or SSL cannot reach the url of your site.
To solve this issue try to restart pagekite before every docker-compose up
using the command `sudo systemctl restart pagekite`

  
