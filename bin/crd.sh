#!/bin/bash

# Arguments
# $1: create/replace/delete

# Create deployments
sudo kubectl $1 -f deployment/interactive-resume-and-url-shortener-deployment.yaml
sudo kubectl $1 -f deployment/slimphp-api-deployment.yaml
sudo kubectl $1 -f deployment/data-quality-checker-deployment.yaml
sudo kubectl $1 -f deployment/dqc-api-deployment.yaml
sudo kubectl $1 -f deployment/mysql-deployment.yaml
sudo kubectl $1 -f deployment/phpmyadmin-deployment.yaml

# Create ingresses
# sudo kubectl $1 -f ingress/kspw-ingress.yaml
# sudo kubectl $1 -f ingress/kellenforthewin-ingress.yaml
# sudo kubectl $1 -f ingress/kellenschmidtcom-ingress.yaml

# Create the issuer
# sudo kubectl $1 -f certificate/issuer-kellenforthewin.yaml
# sudo kubectl $1 -f certificate/issuer-kellenschmidtcom.yaml
