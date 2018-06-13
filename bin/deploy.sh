#!/bin/bash

# Arguments
# $1: DOCKER_USER
# $2: CIRCLE_PROJECT_REPONAME
# $3: CIRCLE_BUILD_NUM

date=$(date +"%d-%m-%Y_%H:%M:%S")
echo "Deploy initiated | deployment/$2 $2=$1/$2:v$3 | $date" >> /tmp/deploy_log.txt

sudo kubectl set image deployment/$2 $2=$1/$2:v$3
