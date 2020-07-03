# Steps to import the production dump

## Remove geoserver data
```
rm -rf ~/geoserver-2.12.5/data_dir/*
```

## Drop database

```
psql -U postgres -h localhost
drop database terrama2;
```

## Import production dump

```
psql -U postgres -h localhost < dump.sql
```

## Remove all the analysis (table with `a_` prefix)

```
psql -U postgres -h localhost -d terrama2

DO $$
DECLARE tablenames text;
BEGIN    
    tablenames := string_agg('"' || tablename || '"', ', ') 
        FROM pg_tables WHERE schemaname = 'public' AND tablename LIKE 'a_%';
    EXECUTE 'DROP TABLE ' || tablenames;
END; $$
```

## Update some column values

```
psql -U postgres -h localhost -d terrama2

UPDATE terrama2.logs set host='localhost';

UPDATE terrama2.data_providers set uri='postgis://postgres:postgres@localhost:5432/terrama2';
```

### On the next update, substitute `<USER>` for your system user name

```
UPDATE terrama2.service_instances set host='',"pathToBinary"='/home/<USER>/mydevel/terrama2/build/bin/terrama2_service',"sshUser"='';

UPDATE terrama2.registered_views set uri = 'http://localhost/geoserver/';

UPDATE terrama2.service_metadata set value = 'http://localhost:8080/geoserver/' where key = 'maps_server';
```

## Run analysis, dynamic data and views

- Run the following analysis: CAR X DETER, CAR X PRODES, CAR X FOCOS and CAR X AQ;

- Run all views.
