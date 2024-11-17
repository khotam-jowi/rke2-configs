# prepare config
mkdir -p /etc/rancher/rke2
cat > /etc/rancher/rke2/config.yaml <<EOL
disable:
  - rke2-ingress-nginx
  - rke2-metrics-server
cni: cilium
kubelet-arg:
  - "max-pods=500"
EOL

# install rke2
curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service

# configure kubectl
echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
echo "alias k='kubectl'" >> ~/.bashrc
source ~/.bashrc

mkdir ~/.kube
cp /etc/rancher/rke2/rke2.yaml ~/.kube/config
chmod 600 ~/.kube/config
