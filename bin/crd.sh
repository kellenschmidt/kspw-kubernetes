#!/bin/bash

# Arguments
# $1: create / replace / delete
# $2: kellenforthewin / kellenschmidtcom

# Set env var for mysql deployment
sed -i "s/placeholder/$2/g" deployment/mysql-deployment.yaml

# Create secrets
sudo kubectl $1 -f secret/mysql-login.yaml
sudo kubectl $1 -f secret/dropbox-uploader.yaml
sudo kubectl $1 -f secret/jwt.yaml
sudo kubectl $1 -f secret/mongo-login.yaml
sudo kubectl $1 -f secret/useragent-api.yaml
# sudo kubectl $1 -f secret/twilio.yaml

if [ "$2" != "kspw" ]; then
  # Create secrets
  sudo kubectl $1 -f secret/oauth2-github.yaml

  # Create the issuer
  sudo kubectl $1 -f issuer/general-issuer.yaml

  # Create dashboard
  sudo kubectl $1 -f dashboard/dashboard-certificate-$2.yaml
  sudo kubectl $1 -f dashboard/oauth2-proxy.yaml
  sudo kubectl $1 -f dashboard/dashboard-ingress-$2.yaml
fi

# Create ingresses
sudo kubectl $1 -f ingress/$2-ingress.yaml

# Create deployments
sudo kubectl $1 -f deployment/interactive-resume-and-url-shortener-deployment.yaml
sudo kubectl $1 -f deployment/slimphp-api-deployment.yaml
sudo kubectl $1 -f deployment/data-quality-checker-deployment.yaml
sudo kubectl $1 -f deployment/dqc-api-deployment.yaml
sudo kubectl $1 -f deployment/mysql-deployment.yaml
sudo kubectl $1 -f deployment/phpmyadmin-deployment.yaml
sudo kubectl $1 -f deployment/graphql-express-api-deployment.yaml
sudo kubectl $1 -f deployment/mongo-deployment.yaml
# sudo kubectl $1 -f deployment/analytics-for-links-and-sites-deployment.yaml
# sudo kubectl $1 -f deployment/laundry-tracker-deployment.yaml

