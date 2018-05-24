# kspw-kubernetes

## Build pods

```
kubectl create -f secrets/mysql-login-secret.yaml
kubectl create -f secrets/dropbox-uploader-secret.yaml
kubectl create -f secrets/jwt-secret.yaml
```

```
kubectl create -f kspw-angular-deployment.yaml
kubectl create -f kspw-mysql-deployment.yaml
kubectl create -f kspw-slim-deployment.yaml
kubectl create -f kspw-phpmyadmin-deployment.yaml
kubectl create -f kspw-ingress-dev.yaml
```

```
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/kspw-angular-deployment.yaml
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/kspw-ingress-dev.yaml
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/kspw-mysql-deployment.yaml
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/kspw-phpmyadmin-deployment.yaml
kubectl create -f https://github.com/kellenschmidt/kspw-kubernetes/blob/master/kspw-slim-deployment.yaml
```

## Update pod

- `kubectl set image deployments/kspw-mysql-slim kspw-slimphp=kellenschmidt/kspw-slimphp:v2`
- `kubectl rollout status deployments/kspw-mysql-slim`
- `kubectl rollout undo deployments/kspw-mysql-slim`

## Enter pod

- `kubectl exec -it kspw-mysql-74784c6b48-mbtpf -c kspw-mysql bash`

## Todo

- Health checking
- HTTPS

## AWS Deployment

- Install Docker

```sh
sudo yum update -y
sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo service docker start
```

- Log out and log back in
- Install Minikube

```sh
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
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
