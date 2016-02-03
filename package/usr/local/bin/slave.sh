#!/bin/bash
docker-compose up -d consul
sleep 10
docker-compose scale swarm=0 && docker-compose scale swarm=1
