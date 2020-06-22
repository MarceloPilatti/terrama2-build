#!/bin/bash

docker stop $(docker ps -aq)
docker rm $(docker ps -aq) -f
docker rmi $(docker images -q) -f
docker network prune -f
docker volume prune -f
