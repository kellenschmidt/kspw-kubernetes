# kspw-kubernetes

## Build pods

```sh
kubectl create -f secret/mysql-login-secret.yaml
kubectl create -f secret/dropbox-uploader-secret.yaml
kubectl create -f secret/jwt-secret.yaml
```

```sh
kubectl create -f deployment/angular-deployment.yaml
kubectl create -f deployment/mysql-deployment.yaml
kubectl create -f deployment/slim-deployment.yaml
kubectl create -f deployment/phpmyadmin-deployment.yaml
```

```sh
kubectl create -f ingress/ingress-kspw.yaml
kubectl create -f ingress/ingress-kellenforthewin.yaml
kubectl create -f ingress/ingress-kellenschmidtcom.yaml
```

```sh
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/deployment/angular-deployment.yaml
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/deployment/mysql-deployment.yaml
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/deployment/slim-deployment.yaml
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/deployment/phpmyadmin-deployment.yaml
```

```sh
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/ingress/ingress-kspw.yaml
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/ingress/ingress-kellenforthewin.yaml
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/ingress/ingress-kellenschmidtcom.yaml
```

## Update pod

- `kubectl set image deployments/mysql-slim slimphp=kellenschmidt/kspw-slimphp:v2`
- `kubectl rollout status deployments/mysql-slim`
- `kubectl rollout undo deployments/mysql-slim`

## Enter pod

- `kubectl exec -it mysql-74784c6b48-mbtpf -c mysql bash`

## Todo

- Health checking
- HTTPS

## AWS Deployment

- Install Docker on Ubuntu EC2 Server

```sh
sudo apt-get update -y && sudo apt-get install -y docker.io
```

- Install Minikube

```sh
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && mv minikube /usr/local/bin/
```

- Install kubectl

```sh
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl
```

- Start Minikube

```sh
sudo -i
minikube start --vm-driver=none
```

- DON'T follow instructions in output to move files and set permissions
- https://github.com/aws-samples/aws-workshop-for-kubernetes/blob/master/03-path-application-development/301-local-development/readme.adoc
