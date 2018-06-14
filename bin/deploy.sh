#!/bin/bash

# Arguments
# $1: DOCKER_USER
# $2: CIRCLE_PROJECT_REPONAME

tag=$(curl -s https://registry.hub.docker.com/v1/repositories/$1/$2/tags | jq ".[].name" | sed -e "s/\"//g" | sort -V | tail -1)

date=$(date +"%d-%m-%Y_%H:%M:%S")
echo "Deploy initiated | deployment/$2 $2=$1/$2:$tag | $date" >> /tmp/deploy_log.txt

sudo kubectl set image deployment/$2 $2=$1/$2:$tag
