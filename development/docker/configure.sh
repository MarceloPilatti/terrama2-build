#!/bin/bash

echo "***********************"
echo "* Installing packages *"
echo "***********************"
echo ""

eval $(egrep -v '^#' .env | xargs)

sudo apt-get update
sudo apt-get -y install apt-transport-https software-properties-common ca-certificates gnupg-agent git

if type -P code >/dev/null; then
   echo "VS Code already installed"
else
   wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
   sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
   sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
   rm -f microsoft.gpg
   sudo apt-get update
   sudo apt-get install -y code
fi

if type -P docker >/dev/null; then
   echo "Docker already installed"
else
   wget -qO- https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') \
      $(lsb_release -cs) \
      stable"
   sudo apt-get update
   sudo apt-get -y install docker-ce docker-ce-cli containerd.io
   sudo service docker start
fi

sudo usermod -aG docker $USER

if type -P docker-compose >/dev/null; then
   echo "Docker compose already installed"
else
   sudo wget -qO /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)"
   sudo chmod +x /usr/local/bin/docker-compose
   sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

mkdir ~/mydevel

echo "********************"
echo "* Cloning projects *"
echo "********************"
echo ""

git clone -b ${TERRAMA2_VERSION} -o upstream https://github.com/TerraMA2/terrama2.git ~/mydevel/terrama2/codebase
GIT_SSL_NO_VERIFY=false git clone -o upstream -b ${TERRALIB_VERSION} https://gitlab.dpi.inpe.br/terralib/terralib.git ~/mydevel/terrama2/terralib/codebase

git clone -b ${SATALERTAS_VERSION} -o upstream https://github.com/TerraMA2/terrama2-report.git ~/mydevel/terrama2-report
git clone -b ${SATALERTAS_VERSION} -o upstream https://github.com/TerraMA2/terrama2-report-server.git ~/mydevel/terrama2-report-server

cp -a report/report_client/environment.ts ~/mydevel/terrama2-report/src/environments/environment.ts
cp -a report/report_client/environment.prod.ts ~/mydevel/terrama2-report/src/environments/environment.prod.ts

cp -a report/report_server/config/config.json ~/mydevel/terrama2-report-server/config/config.json
cp -a report/report_server/geoserver-conf/config.json ~/mydevel/terrama2-report-server/geoserver-conf/config.json

cp -r terrama2/terrama2-conf/webmonitor/instances/ ~/mydevel/terrama2/codebase/webmonitor/config/

cp -a terrama2/terrama2-conf/webapp/db.json ~/mydevel/terrama2/codebase/webapp/config/db.json
cp -a terrama2/terrama2-conf/webapp/settings.json ~/mydevel/terrama2/codebase/webapp/config/settings.json

cp -a terrama2/terrama2-conf/version.json ~/mydevel/terrama2/codebase/share/terrama2/version.json

echo "******************"
echo "* Building image *"
echo "******************"
echo ""

cd terrama2/terrama2-ubuntu-16-04/

sudo docker build -t terrama2-ubuntu-16-04:1.0 .

cd ../../

echo "**************************"
echo "* Running docker compose *"
echo "**************************"
echo ""

sudo docker-compose -p terrama2_dev up -d

sudo chown $USER:$USER -R ~/mydevel/geoserverDir
sudo chmod 755 -R ~/mydevel/geoserverDir
sudo chown $USER:$USER -R ~/mydevel/sharedData
sudo chmod 755 -R ~/mydevel/sharedData

sudo chmod 755 -R ~/mydevel/postgresqlData

xhost +local:docker

echo -e '
127.0.0.1       terrama2_geoserver_dev
127.0.0.1       terrama2_webapp_dev
127.0.0.1       terrama2_webmonitor_dev' | sudo tee -a /etc/hosts > /dev/null

echo -e "
alias monitor-grunt=\"docker exec -it terrama2_webmonitor_dev grunt\"
alias monitor-restart-node=\"docker restart terrama2_webmonitor_dev\"
alias monitor-npm-install=\"docker exec -it terrama2_webmonitor_dev npm install\"

alias adm-grunt=\"docker exec -it terrama2_webapp_dev grunt\"
alias adm-restart-node=\"docker restart terrama2_webapp_dev\"
alias adm-npm-install=\"docker exec -it terrama2_webapp_dev npm install\"

alias webcomp-grunt=\"docker exec -it terrama2_webmonitor_dev bash -c 'cd ~/mydevel/terrama2/codebase/webcomponents/ && grunt'\"
alias webcomp-npm-install=\"docker exec -it terrama2_webmonitor_dev bash -c 'cd ~/mydevel/terrama2/codebase/webcomponents/ && npm install'\"" >> ~/.bashrc
