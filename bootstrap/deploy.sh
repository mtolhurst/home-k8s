#! /bin/sh

set -x

kubectl apply -n argocd -f ./app.yml
