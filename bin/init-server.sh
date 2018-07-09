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
rm get_helm.sh

# Install cert manager
sudo apt install -qq socat
sudo helm install --name cert-manager --set ingressShim.defaultIssuerName=letsencrypt-certs --set ingressShim.defaultIssuerKind=ClusterIssuer stable/cert-manager

# Create secrets
mkdir secret
touch secret/mysql-login-secret.yaml secret/dropbox-uploader-secret.yaml secret/jwt-secret.yaml secret/oauth2-github.yaml

CYAN='\033[0;36m'
# PURPLE='\033[0;35m'
# BLUE='\033[0;34m'
# ORANGE='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'
printf "${GREEN}Now populate the secret files\n"
printf "${CYAN}nano secret/mysql-login-secret.yaml\n"
printf "${CYAN}nano secret/dropbox-uploader-secret.yaml\n"
printf "${CYAN}nano secret/jwt-secret.yaml\n"
printf "${CYAN}nano secret/oauth2-github.yaml\n\n"
