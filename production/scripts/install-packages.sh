#!/bin/bash

echo "***********************"
echo "* Installing packages *"
echo "***********************"
echo ""

apt-get update


apt-get -y install apt-transport-https gnupg2 ca-certificates lsb-release software-properties-common

echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -

apt-get -y install nginx git curl

if type -P docker >/dev/null; then
   echo "Docker already installed"
else
   wget -qO- https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') \
      $(lsb_release -cs) \
      stable"
      
   apt-get update
   apt-get -y install docker-ce docker-ce-cli containerd.io
   service docker start
fi

if type -P docker-compose >/dev/null; then
   echo "Docker compose already installed"
else
   wget -qO /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)"
   chmod +x /usr/local/bin/docker-compose
   ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi