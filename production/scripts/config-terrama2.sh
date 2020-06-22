#!/bin/bash

echo "*********************"
echo "* Building TerraMA² *"
echo "*********************"
echo ""

eval $(egrep -v '^#' .env | xargs)

docker volume create terrama2_shared_vol

docker-compose -p ${TERRAMA2_PROJECT_NAME} up -d

chown 1000:1000 conf/terrama2/terrama2_webapp_settings.json
chown 1000:1000 conf/terrama2/terrama2_webapp_db.json