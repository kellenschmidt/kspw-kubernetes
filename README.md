# kspw-kubernetes

## Kubernetes commands

### Build pods

```sh
kubectl apply -f secret/mysql-login-secret.yaml
kubectl apply -f secret/dropbox-uploader-secret.yaml
kubectl apply -f secret/jwt-secret.yaml
```

```sh
kubectl apply -f deployment/angular-deployment.yaml
kubectl apply -f deployment/dqcweb-deployment.yaml
kubectl apply -f deployment/mysql-deployment.yaml
kubectl apply -f deployment/slim-deployment.yaml
kubectl apply -f deployment/phpmyadmin-deployment.yaml
```

```sh
kubectl apply -f ingress/kspw-ingress.yaml
kubectl apply -f ingress/kellenforthewin-ingress.yaml
kubectl apply -f ingress/kellenschmidtcom-ingress.yaml
```

```sh
kubectl apply -f certificate/issuer.yaml
```

### Update pod

- `kubectl set image deployments/slim slimphp=kellenschmidt/kspw-slimphp:prod`
- `kubectl rollout status deployments/slim`
- `kubectl rollout undo deployments/slim`

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
6. Install Docker on Ubuntu EC2 Server

```sh
sudo -i
sudo apt-get update -qq && sudo apt-get install -qq docker.io
```

7. Install Minikube

```sh
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && mv minikube /usr/local/bin/
```

8. Install kubectl

```sh
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl
```

9. Start Minikube

```sh
minikube start --vm-driver=none
```

10. DON'T follow instructions in output to move files and set permissions

11. Verify proper installation

```sh
minikube status
```

12. Install Helm and Tiller

```sh
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
helm init
kubectl get pods --namespace kube-system
```

13. Install cert manager

```sh
apt-get install -qq socat
helm install --name cert-manager --set ingressShim.defaultIssuerName=letsencrypt-prod2 --set ingressShim.defaultIssuerKind=ClusterIssuer stable/cert-manager
```

14. Create issuer

```sh
kubectl apply -f certificate/issuer.yaml
```

15. Create all secrets, deployments, and ingresses

## Resources

- Cert manager, let's encrypt
    - https://medium.com/containerum/how-to-launch-nginx-ingress-and-cert-manager-in-kubernetes-55b182a80c8f
    - https://amasucci.com/post/2018/03/17/how-to-generate-tls-certificates-with-cert-manager-and-lets-encrypt-in-kubernetes/
    - https://cert-manager.readthedocs.io/en/latest/reference/ingress-shim.html

- Creating minikube cluster
    - https://github.com/aws-samples/aws-workshop-for-kubernetes/blob/master/03-path-application-development/301-local-development/readme.adoc
