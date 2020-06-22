#!/bin/bash

eval $(egrep -v '^#' .env | xargs)

docker-compose -p ${TERRAMA2_PROJECT_NAME} down

docker-compose -p ${TERRAMA2_PROJECT_NAME} pull

docker-compose -p ${TERRAMA2_PROJECT_NAME} up -d

chown 1000:1000 conf/terrama2/terrama2_webapp_settings.json
chown 1000:1000 conf/terrama2/terrama2_webapp_db.json