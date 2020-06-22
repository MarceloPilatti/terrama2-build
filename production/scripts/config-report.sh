#!/bin/bash

echo "*******************"
echo "* Building report *"
echo "*******************"
echo ""

eval $(egrep -v '^#' .env | xargs)

docker-compose -f docker/report/docker-compose.yml -p ${TERRAMA2_PROJECT_NAME}_report down --rmi all -v

docker-compose -f docker/report/docker-compose.yml -p ${TERRAMA2_PROJECT_NAME}_report up --build --force-recreate -d

docker image rm node:12 nginx -f

service nginx restart
