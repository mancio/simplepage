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

### First rum

1. be sure `return 301 https://www.manciotech.fun;` is commented (to give the possibility 
   to certbot to access port 80)
2. execute `docker-compose up`
3. stop execution with ctrl+c
4. uncomment `return 301 https://www.manciotech.fun;` (force a secure connection)
5. execute `docker-compose up`



  
