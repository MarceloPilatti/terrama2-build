#!/bin/bash

docker exec -it terrama2_webapp_dev grunt
docker exec -it terrama2_webmonitor_dev bash -c 'cd ~/mydevel/terrama2/codebase/webcomponents/ && grunt'
docker exec -it terrama2_webmonitor_dev grunt