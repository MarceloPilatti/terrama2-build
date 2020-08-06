#!/bin/bash

eval $(egrep -v '^#' .env | xargs)

cd /home/$USER

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

nvm install 8

nvm install 12

nvm use 12

sudo chown -R 1000:1000 /home/$(id -un 1000)/.npm

sudo npm install -g @angular/cli@8.3.20

git clone -b ${SATALERTAS_VERSION} -o upstream https://github.com/TerraMA2/terrama2-report.git /home/$USER/mydevel/terrama2-report
git clone -b ${SATALERTAS_VERSION} -o upstream https://github.com/TerraMA2/terrama2-report-server.git /home/$USER/mydevel/terrama2-report-server

cd /home/$USER/mydevel/terrama2-report
npm install
cp -a src/environments/environment.ts.example src/environments/environment.ts
cp -a src/environments/environment.prod.ts.example src/environments/environment.prod.ts

cd /home/$USER/mydevel/terrama2-report-server
npm install
cp -a config/config.json.example config/config.json
cp -a geoserver-conf/config.json.example geoserver-conf/config.json

echo -e "
alias report-server-start=\"nvm use 12;cd ~/mydevel/terrama2-report-server/;npm start\"
alias report-client-start=\"nvm use 12;cd ~/mydevel/terrama2-report/;ng serve\"" >> ~/.bashrc

source ~/.bashrc
