#!/bin/sh

rsa_key_size=4096
path="/home/pi/DockerVol/certbot/key"

openssl req -x509 -nodes -newkey rsa:$rsa_key_size -days 1\
    -keyout "$path/privkey.pem" \
    -out "$path/fullchain.pem"