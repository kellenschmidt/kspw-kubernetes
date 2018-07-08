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
sudo kubectl create -f certificate/issuer-kellenforthewin.yaml
sudo kubectl create -f certificate/issuer-kellenschmidtcom.yaml
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
cd kspw-kubernetes/
```

7. Make initialization script executable

```sh
chmod +x bin/init-server.sh
```

8. Populate secret files

9. Create deployments, ingress, and certificate

```sh
bash bin/crd.sh create
```

10. Install Kubernetes Dashboard

```sh
sudo helm install stable/oauth2-proxy --namespace=kube-system -f dashboard/proxy-values-kellenforthewin.yaml --name=k8s-dash-oauth2
sudo helm install stable/kubernetes-dashboard --namespace=kube-system -f dashboard/dashboard-values.yaml --name=k8s-dash
```

<!-- sudo helm upgrade --namespace=kube-system k8s-dash stable/kubernetes-dashboard -f dashboard-values.yaml -->

## Resources

- Cert manager, let's encrypt
    - https://medium.com/containerum/how-to-launch-nginx-ingress-and-cert-manager-in-kubernetes-55b182a80c8f
    - https://amasucci.com/post/2018/03/17/how-to-generate-tls-certificates-with-cert-manager-and-lets-encrypt-in-kubernetes/
    - https://cert-manager.readthedocs.io/en/latest/reference/ingress-shim.html

- Creating minikube cluster
    - https://github.com/aws-samples/aws-workshop-for-kubernetes/blob/master/03-path-application-development/301-local-development/readme.adoc
