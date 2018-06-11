#!/bin/bash

# Arguments
# $1: CIRCLE_PROJECT_REPONAME
# S2: CIRCLE_BUILD_NUM

date=$(date +"%d-%m-%Y_%H:%M:%S")
echo "Deploy initiated | $1 (Build #$2) | $date" >> /tmp/deploy_log.txt
