#!/bin/bash

docker exec -it terrama2_pg bash -c "cd /backup;psql -h localhost -U postgres < dump.sql"