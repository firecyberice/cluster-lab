#!/bin/bash
docker-compose stop
docker-compose rm -f

sudo service docker restart

sleep 20
