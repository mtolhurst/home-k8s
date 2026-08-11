#! /bin/sh

set -x

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch configmap argocd-cm -n argocd --type merge -p '
{
  "data": {
    "resource.exclusions": "- apiGroups:\n    - cilium.io\n  kinds:\n    - CiliumIdentity\n    - CiliumEndpoint\n    - CiliumEndpointSlice\n  clusters:\n    - \"*\"\n"
  }
}'


kubectl apply -n argocd -f ./argocd-repositories.yml
kubectl apply -n argocd -f ./infra.yml

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

