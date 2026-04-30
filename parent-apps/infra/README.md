# Infra parent app

This is an argocd parent app, following the app-of-apps pattern

It is designed to provision low level infrastructure required early on during cluster bootstrapping

## TODO

* Need to move some potentially sensitive apps in here.
  * Longhorn will be the most annoying to move
  * Metallb should be fine, but with downtime
  * Cert manager
  * External DNS
  * Intel stuff
  * node-feature-discovery
  * Envoy-gateway
  
