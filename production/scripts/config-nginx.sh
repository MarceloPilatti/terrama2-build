#!/bin/bash

echo "****************************"
echo "* Configuring Nginx *"
echo "****************************"
echo ""

mkdir /etc/nginx/sites-enabled/

mkdir /etc/nginx/sites-available/

cp -v conf/nginx/sites-available/terrama2-default /etc/nginx/sites-available/

ln -s /etc/nginx/sites-available/terrama2-default -t /etc/nginx/sites-enabled/

mkdir /etc/nginx/terrama2/

cp -v conf/nginx/terrama2/terrama2.conf /etc/nginx/terrama2/
cp -v conf/nginx/proxy_params /etc/nginx/
cp -v conf/nginx/nginx.conf /etc/nginx/

service nginx reload