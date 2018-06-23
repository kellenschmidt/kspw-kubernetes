# Make deploy script executable
chmod +x bin/deploy.sh bin/crd.sh

# Install Docker on Ubuntu EC2 Server
sudo apt update -qq && sudo apt install -qq docker.io jq

# Install Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl

# Start Minikube
sudo minikube start --vm-driver=none

# Enable addons
sudo minikube addons enable ingress
sudo minikube addons enable dashboard
sudo minikube addons enable heapster

# Install Helm and Tiller
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
sudo helm init
sudo kubectl get pods --namespace kube-system

# Install cert manager
sudo apt install -qq socat
sudo helm install --name cert-manager --set ingressShim.defaultIssuerName=letsencrypt-kellenforthewin --set ingressShim.defaultIssuerKind=ClusterIssuer stable/cert-manager

# Create secrets
touch mysql-login-secret.yaml dropbox-uploader-secret.yaml jwt-secret.yaml

GREEN='\033[0;32m'
NC='\033[0m'
printf "${GREEN}Now populate the secret files\n\n"
