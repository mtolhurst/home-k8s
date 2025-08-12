# Home k8s apps

## Bootstrapping

In the `bootstrap` subdirectory, execute the bootstrap script.

## Networking

Apps are exposed using metallb, running in BGP mode.
The BGP peering is setup in ./infra/metallb/metallb-resource.yaml

In my case, this is configured to use an opnsense router with the frr plugin.

## App of apps pattern

https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/#app-of-apps-pattern

All apps should be declared in ./parent/templates, with a separate yaml file for each application

## Secrets
A number of secrets are not stored here, and are required for all apps to work

* CNPG backup AWS creds
  * Name - pg-backup-aws-creds
  * Requires access to s3
  * ```
      kubectl create secret generic pg-backup-aws-creds \
       --from-literal=ACCESS_KEY_ID=<key id>\
       --from-literal=ACCESS_SECRET_KEY=<secret key>
    ```
