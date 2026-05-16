#!/bin/bash

# install longhornctl for setup and check
curl -sSfL -o longhornctl https://github.com/longhorn/cli/releases/download/v1.11.1/longhornctl-linux-amd64
chmod +x longhornctl
sudo mv longhornctl /usr/local/bin
kubectl create ns longhorn-system
longhornctl --kubeconfig $HOME/.kube/config install preflight
longhornctl --kubeconfig $HOME/.kube/config check preflight

# install longhorn (need worker node)
helm repo add longhorn https://charts.longhorn.io
helm repo update
helm install longhorn longhorn/longhorn \
  --namespace longhorn-system \
  --version 1.11.1 