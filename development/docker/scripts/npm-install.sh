#!/bin/bash

docker exec -it terrama2_webapp_dev npm install
docker exec -it terrama2_webmonitor_dev bash -c 'cd ~/mydevel/terrama2/codebase/webcomponents/ && npm install'
docker exec -it terrama2_webmonitor_dev npm install