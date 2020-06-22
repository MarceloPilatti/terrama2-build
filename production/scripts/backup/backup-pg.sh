#!/bin/bash

docker exec -it terrama2_pg bash -c "pg_dumpall -U postgres -h localhost -f /backup/dump.sql -v;cd /backup;tar cvf - dump.sql | gzip -9 - > dump.tar.gz;cp /var/lib/postgresql/data/postgresql.conf /backup"