# TerraMA² production environment configuration with Docker

This automatically configures TerraMA² prodution environment with [Docker](https://docs.docker.com/get-docker/).

## Folder structure

- `conf` - Contains all configuration files necessary to configure Nginx, PostgreSQL and TerraMA²'s web applications (webapp and webmonitor).
- `docker` - Contains the Dockerfiles and scripts necessary to run the build the images and configure the enviroment;
- `scripts` - Scripts to automate the configuration.

## Usage

Just configure `.env` file if necessary and run:

```bash
./configure.sh
```

The `configure.sh` runs some scripts that can be found on the folder `production/scripts`: 

- `install-packages.sh` - Install git, docker, Docker compose and nginx;
- `config-version.sh` - Generate config files using the variables contained on the `.env` file;
- `config-terrama2.sh` - Runs TerraMA² Docker Compose;
- `config-report.sh` - Runs Docker Compose of the [report](https://github.com/TerraMA2/terrama2-report) application;
- `config-postgres.sh` - Copy PostgreSQL configuration;
- `config-nginx.sh` - Copy Nginx configuration.

## Other scripts

- `build-images.sh` - Build all TerraMA² images using the Dockerfiles on the docker directory;
- `deploy` - Push all TerraMA² images to Dockerhub.

## Environment variables file

The `.env` file contains the following variables:

- `TERRAMA2_PROJECT_NAME` - Name of the project used on Docker Compose project parameter;
- `TERRAMA2_DOCKER_REGISTRY` - Name of the registry on Docker Hub;
- `TERRAMA2_TAG` - TerraMA² version;
- `TERRAMA2_CONFIG_DIR` - Path of the config folder (located on `production/conf`);
- `TERRAMA2_DATA_DIR` - Name of the data volume;
- `TERRAMA2_WEBAPP_ADDRESS` - Host and port to access the webapp container;
- `TERRAMA2_WEBMONITOR_ADDRESS` - Host and port to access the webmonitor container;
- `REPORT_CLIENT_PORT` - Port to access the report client container;
- `REPORT_SERVER_PORT` - Port to access the report server container;
- `TERRAMA2_DNS` - DNS of the server;
- `TERRAMA2_BASE_PATH` - Base URL of the application included after the DNS (default is '/');
- `PG_MAX_CONN` - Max number of connection on PostgreSQL;
- `PG_BACKUP_DIR` - Directory used as a backup of the PostgreSQL;
- `PG_DATABASE` - Name of the database;
- `GEOSERVER_BACKUP_DIR` - Directory used as a backup of the Geoserver;
- `NGINX_USER` - Nginx user;
- `NGINX_PORT` - Nginx port.

## Deploy

To update the version running on a server, run the script `deploy-terrama2.sh`. To update the report application, run `deploy-report.sh`.

## Update versions

To update the versions of TerraMA² and report applications, just run the scripts `deploy-report.sh` and `deploy-terrama2.sh` located on the root folder.

## Backup and restore

To make a backup of the database and Geoserver just run the scripts `backup-pg.sh` and `backup-geoserver.sh`. The backup files will be located on the paths described on `.env` folder. To restore the data, run the scripts `restore-pg.sh` and `restore-geoserver.sh`.

## Manually configuring

To manually configure the environment, follow this steps:

### Install Docker and Docker Compose

Install Docker using [this link](https://docs.docker.com/get-docker/) and Docker Compose using [this link](https://docs.docker.com/compose/install/), or run:

### Clone docker scripts

```
git clone https://github.com/MarceloPilatti/terrama2-build.git

cd terrama2-build/production
```

### Create terrama2_shared_vol volume

```
docker volume create terrama2_shared_vol
```

### Set env variables on .env file and generate configuration files

```
./configure-version.sh
```

### Run docker-compose

```
docker-compose -p terrama2 up -d
```