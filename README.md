# kspw-kubernetes

## Kubernetes commands

### Build pods

```sh
sudo kubectl create -f secret/mysql-login-secret.yaml
sudo kubectl create -f secret/dropbox-uploader-secret.yaml
sudo kubectl create -f secret/jwt-secret.yaml
```

```sh
sudo kubectl create -f deployment/interactive-resume-and-url-shortener-deployment.yaml
sudo kubectl create -f deployment/data-quality-checker-deployment.yaml
sudo kubectl create -f deployment/dqc-api-deployment.yaml
sudo kubectl create -f deployment/mysql-deployment.yaml
sudo kubectl create -f deployment/slimphp-api-deployment.yaml
sudo kubectl create -f deployment/phpmyadmin-deployment.yaml
```

```sh
sudo kubectl create -f ingress/kspw-ingress.yaml
sudo kubectl create -f ingress/kellenforthewin-ingress.yaml
sudo kubectl create -f ingress/kellenschmidtcom-ingress.yaml
```

```sh
sudo kubectl create -f certificate/issuer-prod2.yaml
```

### Update pod

- `kubectl set image deployments/slimphp-api slimphp-api=kellenschmidt/slimphp-api:v4`
- `kubectl rollout status deployments/slimphp-api`
- `kubectl rollout undo deployments/slimphp-api`

### Enter pod

- `kubectl exec -it mysql-74784c6b48-mbtpf -c mysql-db bash`

## AWS Deployment

1. Launch Ubuntu EC2 instance
2. Create keypair for SSH
3. Configure security group to allow HTTP(80), HTTPS(443), and SSH(22)
4. Create and associate elastic IP address
5. Optionally add custom password-protected keypair via SSH and authorized_keys
    * Add public key to `~/.ssh/authorized_keys` on server
    * Might need to remove current kellenschmidt.com entry from `~/.ssh/known_hosts` locally

6. Clone repository

```sh
git clone https://github.com/kellenschmidt/kspw-kubernetes.git
```

7. Make deploy script executable

```sh
chmod +x ~/kspw-kubernetes/bin/deploy.sh
```

8. Install Docker on Ubuntu EC2 Server

```sh
sudo -i
sudo apt-get update -qq && sudo apt-get install -qq docker.io
```

9. Install Minikube

```sh
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```

10. Install kubectl

```sh
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl
```

11. Start Minikube

```sh
sudo minikube start --vm-driver=none
sudo minikube status
```

12. DON'T follow instructions in output to move files and set permissions

13. Enable addons

```sh
sudo minikube addons enable ingress
sudo minikube addons enable dashboard
sudo minikube addons enable heapster
```

14. Install Helm and Tiller

```sh
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
sudo helm init
sudo kubectl get pods --namespace kube-system
```

15. Install cert manager

```sh
sudo apt-get install -qq socat
sudo helm install --name cert-manager --set ingressShim.defaultIssuerName=letsencrypt-prod2 --set ingressShim.defaultIssuerKind=ClusterIssuer stable/cert-manager
```

16. Create issuer

```sh
sudo kubectl create -f certificate/issuer-prod2.yaml
```

17. Create all secrets, deployments, and ingresses

## Resources

- Cert manager, let's encrypt
    - https://medium.com/containerum/how-to-launch-nginx-ingress-and-cert-manager-in-kubernetes-55b182a80c8f
    - https://amasucci.com/post/2018/03/17/how-to-generate-tls-certificates-with-cert-manager-and-lets-encrypt-in-kubernetes/
    - https://cert-manager.readthedocs.io/en/latest/reference/ingress-shim.html

- Creating minikube cluster
    - https://github.com/aws-samples/aws-workshop-for-kubernetes/blob/master/03-path-application-development/301-local-development/readme.adoc
