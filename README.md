# Home k8s apps

## Bootstrapping

In the `bootstrap` subdirectory, execute the bootstrap script.

## Restoring backups

### Velero

Any persistent volume with a label specifying backups should be automatically backed up by velero, to the NAS via NFS/versityGW.
To restore all volumes, first find the latest good backup with `velero backup get`.
Following this, run `velero restore create <name> --from-backup <backup-name>`.

Alternatively, if you only need to restore a single application, you can include the `--include-namespaces` arg to only restore a single namespace.

### CNPG

For any CNPG cluster requiring backups, the source file defining the DB should already contain a commented out section specifying the restore manifest.

To restore a db

1. Uncomment the commented section in the relevant DB file
2. Comment out the `spec.plugins` block
3. Delete the existing DB (if it exists)
4. Manually apply the DB manifest (to the correct namespace)
5. Restore the working tree, don't commit any of these changes to git.

Alternatively, if performing a full cluster restore

1. For all CNPG clusters, uncomment the `externalClusters` section, and comment out the `spec.plugins` section.
2. Commit/push changes
3. Run the `bootstrap/deploy.sh` script to deploy the applications
4. After bootstrapping is complete, revert the changes to db files.
 
### NFS

Any NFS volumes should have backups/restores handled by the NAS. K8s just mounts the volumes that already exist there.

## Networking

Apps are exposed using metallb, running in BGP mode.
The BGP peering is setup in ./infra/metallb/metallb-resource.yaml

In my case, this is configured to use an opnsense router with the frr plugin.

## App of apps pattern

https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/#app-of-apps-pattern

All apps should be declared in ./parent/templates, with a separate yaml file for each application

## Secrets
A number of secrets are not stored here, and are required for all apps to work

* ExternalDNS credentials
  * Name: external-dns
  * Requires access to modify route53 hosted zones
  * https://kubernetes-sigs.github.io/external-dns/v0.20.0/docs/tutorials/aws/#create-the-static-credentials
* Cert manager creds
  * Name: route53-credentials-secret
  * Requires route53 txt access
  * ```
     kubectl create secret generic route53-credentials-secret -n cert-manager \
       --from-literal=access-key-id='' \
       --from-literal=secret-access-key=''
  ```

# TODO
* Move to local git
* Move stuff to parent app
* Get all apps using externalDNS
  * Move everything we can behind envoy gateway with a cert

