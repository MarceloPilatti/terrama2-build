#!/bin/bash

echo "****************************"
echo "* Configuring config files *"
echo "****************************"
echo ""

# To debug each command, uncomment next line
# set -x

# Expand variables defined in file ".env" to current script execution
eval $(egrep -v '^#' .env | xargs)

for image in conf/terrama2/terrama2_webapp_settings.json.in \
             conf/terrama2/terrama2_webapp_db.json.in \
             conf/terrama2/terrama2_webmonitor.json.in \
             docker/terrama2/Dockerfile.in \
             docker/webapp/Dockerfile.in \
             docker/webmonitor/Dockerfile.in \
             conf/nginx/sites-available/terrama2-default.in \
             conf/nginx/terrama2/terrama2.conf.in \
             conf/nginx/nginx.conf.in \
             docker/report/report-server/config.json.in \
             docker/report/report-client/config/environment.prod.ts.in \
             docker/report/report-server/geoserver-conf/config.json.in \
             docker/report/report-client/Dockerfile.in \
             docker/report/docker-compose.yml.in \
             conf/postgres/postgresql.conf.in; do
  sed -r \
        -e 's!%%TERRAMA2_TAG%%!'"${TERRAMA2_TAG}"'!g' \
        -e 's!%%TERRAMA2_PROJECT_NAME%%!'"${TERRAMA2_PROJECT_NAME}"'!g' \
        -e 's!%%TERRAMA2_DOCKER_REGISTRY%%!'"${TERRAMA2_DOCKER_REGISTRY}"'!g' \
        -e 's!%%TERRAMA2_PROTOCOL%%!'"${TERRAMA2_PROTOCOL}"'!g' \
        -e 's!%%TERRAMA2_DNS%%!'"${TERRAMA2_DNS}"'!g' \
        -e 's!%%TERRAMA2_BASE_PATH%%!'"${TERRAMA2_BASE_PATH}"'!g' \
        -e 's!%%TERRAMA2_WEBAPP_ADDRESS%%!'"${TERRAMA2_WEBAPP_ADDRESS}"'!g' \
        -e 's!%%TERRAMA2_WEBMONITOR_ADDRESS%%!'"${TERRAMA2_WEBMONITOR_ADDRESS}"'!g' \
        -e 's!%%TERRAMA2_GEOSERVER_ADDRESS%%!'"${TERRAMA2_GEOSERVER_ADDRESS}"'!g' \
        -e 's!%%REPORT_CLIENT_PORT%%!'"${REPORT_CLIENT_PORT}"'!g' \
        -e 's!%%REPORT_SERVER_PORT%%!'"${REPORT_SERVER_PORT}"'!g' \
        -e 's!%%PG_MAX_CONN%%!'"${PG_MAX_CONN}"'!g' \
        -e 's!%%PG_DATABASE%%!'"${PG_DATABASE}"'!g' \
        -e 's!%%NGINX_USER%%!'"${NGINX_USER}"'!g' \
        -e 's!%%NGINX_PORT%%!'"${NGINX_PORT}"'!g' \
        -e 's!%%TERRAMA2_SSL%%!'"${TERRAMA2_SSL}"'!g' \
      "${image}" > "${image::-3}"
done
