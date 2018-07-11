#!/bin/bash

# Arguments
# $1: create / replace / delete
# $2: kellenforthewin / kellenschmidtcom

# Set env var for mysql deployment
sed -i "s/placeholder/$2/g" deployment/mysql-deployment.yaml

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
  sudo kubectl $1 -f dashboard/dashboard-certificate-$2.yaml
  sudo kubectl $1 -f dashboard/oauth2-proxy.yaml
  sudo kubectl $1 -f dashboard/dashboard-ingress-$2.yaml

  # Create secrets
  sudo kubectl $1 -f secret/oauth2-github.yaml
fi

# Create secrets
sudo kubectl $1 -f secret/mysql-login-secret.yaml
sudo kubectl $1 -f secret/dropbox-uploader-secret.yaml
sudo kubectl $1 -f secret/jwt-secret.yaml

# Create ingresses
sudo kubectl $1 -f ingress/$2-ingress.yaml
