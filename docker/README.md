# TerraMA² development environment configuration with Docker

This automatically configures TerraMA² development environment with [Docker](https://docs.docker.com/get-docker/).

## Folder structure

- `geoserver` - Contains the Dockerfile to build Geoserver image.
- `report` - Contains the Dockerfiles and configuration files to build the report application;
- `scripts` - Scripts to automate the configuration;
- `terrama2` - Dockerfile and configuration to build the TerraMA² application.

## Usage

Just configure `.env` file if necessary and run:

```bash
./configure.sh
```

## Environment variables file

The `.env` file contains the following variables:

`WEBAPP_NAME` - Name of the webapp container;
`WEBAPP_PORT` - Host and port to access webapp container;
`WEBAPP_DEBUG_PORT` - Port to debug webapp application;

`WEBMONITOR_NAME` - Name of the webmonitor container;
`WEBMONITOR_PORT` - Host and port to access webmonitor container;
`WEBMONITOR_DEBUG_PORT` - Port to debug webmonitor application;

`REPORT_SERVER_NAME` - Name of the report server container;
`REPORT_SERVER_PORT` - Host and port to access report server container;
`REPORT_SERVER_DEBUG_PORT` - Port to debug report server application;
`REPORT_SERVER_NODE_ENV` - Set NODE_ENV environment variable (PRODUCTION or DEVELOPMENT);

`REPORT_CLIENT_NAME` - Name of the report client container;
`REPORT_CLIENT_PORT` - Host and port to access report client container;
`REPORT_CLIENT_DEBUG_PORT` - Port to debug report client application;
`REPORT_CLIENT_NODE_ENV` - Set NODE_ENV environment variable (PRODUCTION or DEVELOPMENT);

`PG_NAME` - Name of the PostgreSQL container;
`PG_PORT` - Host and port to access PostgreSQL container;
`PG_PASSWORD` - PostgreSQL password;

`GEOSERVER_NAME` - Name of the Geoserver container;
`GEOSERVER_PORT` - Host and port to access the Geoserver container;