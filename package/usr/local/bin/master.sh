#!/bin/bash

source slave.sh

sleep 10

docker-compose scale swarmmanage=0 && docker-compose scale swarmmanage=1
docker-compose scale ui=0 && docker-compose scale ui=1
