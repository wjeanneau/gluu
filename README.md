# Gluu

[Gluu](https://gluu.org/) - Enterprise ready, free open source software for identity & access management (IAM).

## TL;DR;

```console
$ helm install stable/gluu
```

## Introduction

This chart bootstraps a [Gluu](https://gluu.io/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.3+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name my-release stable/gluu
```

The command deploys Gluu on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Gluu chart and their default values.

Parameter | Description | Default
--------- | ----------- | -------
`oxtrust.name` | oxtrust container name | `oxtrust`
`oxtrust.image.repository` | oxtrust container image repository | `alertmanager`
`oxtrust.image.tag` | oxtrust container image tag | `3.1.4_dev`
`oxtrust.image.pullPolicy` | oxtrust container image pull policy | `IfNotPresent`
`oxtrust.priorityClassName` | priorityClassName | `""`
`oxtrust.extraArgs` | Additional oxtrust container arguments | `{}`
`oxtrust.ingress.enabled` | If true, oxtrust Ingress will be created | `false`
`oxtrust.ingress.annotations` | oxtrust Ingress annotations | `{}`
`oxtrust.ingress.extraLabels` | oxtrust Ingress additional labels | `{}`
`oxtrust.ingress.hosts` | oxtrust Ingress hostnames | `[]`
`oxtrust.ingress.tls` | oxtrust Ingress TLS configuration (YAML) | `[]`
`oxtrust.tolerations` | node taints to tolerate (requires Kubernetes >=1.6) | `[]`
`oxtrust.nodeSelector` | node labels for oxtrust pod assignment | `{}`
`oxtrust.podAnnotations` | annotations to be added to oxtrust pods | `{}`
`oxtrust.replicaCount` | desired number of oxtrust pods | `1`
`oxtrust.resources` | oxtrust pod resource requests & limits | `{}`
`oxtrust.securityContext` | Custom [security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for Alert Manager containers | `{}`
`oxtrust.service.annotations` | annotations for oxtrust service | `{}`
`oxtrust.service.labels` | labels for oxtrust service | `{}`
`oxtrust.service.clusterIP` | internal oxtrust cluster service IP | `""`
`oxtrust.service.servicePort` | oxtrust service port | `80`
`oxtrust.service.type` | type of oxtrust service to create | `ClusterIP`
`oxtrust.persistentVolume.enabled` | If true, oxtrust will create a Persistent Volume Claim | `true`
`oxtrust.persistentVolume.accessModes` | oxtrust data Persistent Volume access modes | `[ReadWriteOnce]`
`oxtrust.persistentVolume.annotations` | Annotations for oxtrust Persistent Volume Claim | `{}`
`oxtrust.persistentVolume.existingClaim` | oxtrust data Persistent Volume existing claim name | `""`
`oxtrust.persistentVolume.size` | oxtrust data Persistent Volume size | `2Gi`
`oxtrust.persistentVolume.storageClass` | oxtrust data Persistent Volume Storage Class | `unset`

`oxtrust.affinity` | pod affinity | `{}`
`oxtrust.schedulerName` | oxtrust alternate scheduler name | `nil`

`rbac.create` | If true, create & use RBAC resources | `true`
`networkPolicy.enabled` | Enable NetworkPolicy | `false` |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install stable/gluu --name my-release \
    --set server.terminationGracePeriodSeconds=360
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install stable/gluu --name my-release -f values.yaml
```

> **Tip**: You can use the default [values.yaml](values.yaml)

### RBAC Configuration
Roles and RoleBindings resources will be created automatically for `server` and `kubeStateMetrics` services.

To manually setup RBAC you need to set the parameter `rbac.create=false` and specify the service account to be used for each service by setting the parameters: `serviceAccounts.{{ component }}.create` to `false` and `serviceAccounts.{{ component }}.name` to the name of a pre-existing service account.

> **Tip**: You can refer to the default `*-clusterrole.yaml` and `*-clusterrolebinding.yaml` files in [templates](templates/) to customize your own.

### ConfigMap Files
AlertManager is configured through [oxtrust.yml](https://gluu.io/docs/alerting/configuration/). This file (and any others listed in `oxtrustFiles`) will be mounted into the `oxtrust` pod.

Gluu is configured through [gluu.yml](https://gluu.io/docs/operating/configuration/). This file (and any others listed in `serverFiles`) will be mounted into the `server` pod.

### Ingress TLS
If your cluster allows automatic creation/retrieval of TLS certificates (e.g. [kube-lego](https://github.com/jetstack/kube-lego)), please refer to the documentation for that mechanism.

To manually configure TLS, first create/retrieve a key & certificate pair for the address(es) you wish to protect. Then create a TLS secret in the namespace:

```console
kubectl create secret tls gluu-server-tls --cert=path/to/tls.cert --key=path/to/tls.key
```

Include the secret's name, along with the desired hostnames, in the oxtrust/server Ingress TLS section of your custom `values.yaml` file:

```yaml
server:
  ingress:
    ## If true, Gluu server Ingress will be created
    ##
    enabled: true

    ## Gluu server Ingress hostnames
    ## Must be provided if Ingress is enabled
    ##
    hosts:
      - gluu.domain.com

    ## Gluu server Ingress TLS configuration
    ## Secrets must be manually created in the namespace
    ##
    tls:
      - secretName: gluu-tls
        hosts:
          - gluu.domain.com
```

### NetworkPolicy

Enabling Network Policy for Gluu will secure connections to Alert Manager
and Kube State Metrics by only accepting connections from Gluu Server.
All inbound connections to Gluu Server are still allowed.

To enable network policy for Gluu, install a networking plugin that
implements the Kubernetes NetworkPolicy spec, and set `networkPolicy.enabled` to true.

If NetworkPolicy is enabled for Gluu' scrape targets, you may also need
to manually create a networkpolicy which allows it.
