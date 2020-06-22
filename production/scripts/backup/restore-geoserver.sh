#!/bin/bash

docker exec -it terrama2_geoserver bash -c "cd /opt/geoserver/data_dir/;tar xvf /backup/geoserverData.tar.gz"