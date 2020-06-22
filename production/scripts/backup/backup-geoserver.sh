#!/bin/bash

docker exec -it terrama2_geoserver bash -c "cd /opt/geoserver/data_dir/;tar cvf - * | gzip -9 - > /backup/geoserverData.tar.gz"