# kspw-kubernetes

## Build pods

- `kubectl create -f mysql-login-secret.yaml`
- `kubectl create -f dropbox-uploader-secret.yaml`
- `kubectl create -f kspw-angular-deployment.yaml`
- `kubectl create -f kspw-mysql-slim-deployment.yaml`
- `kubectl create -f kspw-phpmyadmin-deployment.yaml`
- `kubectl create -f kspw-ingress-dev.yaml`

## Update pod

- `kubectl set image deployments/kspw-mysql-slim kspw-slimphp=kellenschmidt/kspw-slimphp:v2`
- `kubectl rollout status deployments/kspw-mysql-slim`
- `kubectl rollout undo deployments/kspw-mysql-slim`

## Enter pod

- `kubectl exec -it kspw-mysql-slim-74784c6b48-mbtpf -c kspw-mysql bash`

## Todo

- Fix routing to index on kspw-slimapi image by editing apache .conf file
