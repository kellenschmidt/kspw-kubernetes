#!/bin/bash

# Arguments
# $1: create / replace / delete
# $2: kellenforthewin / kellenschmidtcom

# Create deployments
sudo kubectl $1 -f deployment/interactive-resume-and-url-shortener-deployment.yaml
sudo kubectl $1 -f deployment/slimphp-api-deployment.yaml
sudo kubectl $1 -f deployment/data-quality-checker-deployment.yaml
sudo kubectl $1 -f deployment/dqc-api-deployment.yaml
sudo kubectl $1 -f deployment/mysql-deployment.yaml
sudo kubectl $1 -f deployment/phpmyadmin-deployment.yaml

if [ "$2" != "kspw" ]; then
  # Create the issuer
  sudo kubectl $1 -f issuer/general-issuer.yaml

  # Create dashboard
  sudo kubectl $1 -f dashboard/oauth2-proxy-$2.yaml
  sudo kubectl $1 -f dashboard/dashboard-ingress-$2.yaml
fi

# Create ingresses
sudo kubectl $1 -f ingress/$2-ingress.yaml
