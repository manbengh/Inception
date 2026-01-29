#!/bin/bash
set -e

openssl req -x509 -nodes -days 365 \
	-subj "/CN=vboxuser.42.fr" \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/server.key \
	-out /etc/nginx/ssl/server.crt

