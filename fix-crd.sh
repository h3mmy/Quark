#!/bin/bash

for crd_name in  certificaterequests.cert-manager.io certificates.cert-manager.io challenges.acme.cert-manager.io clusterissuers.cert-manager.io issuers.cert-manager.io orders.acme.cert-manager.io; do
    KIND=${crd_name}
    NAME=default
    RELEASE=cert-manager
    NAMESPACE=cert-manager
    echo "Using following values..."
    echo Kind: $KIND
    echo NAME: $NAME
    echo RELEASE: $RELEASE
    echo NAMESPACE: $NAMESPACE
    kubectl -n $NAMESPACE annotate $KIND $NAME meta.helm.sh/release-name=$RELEASE
    kubectl -n $NAMESPACE annotate $KIND $NAME meta.helm.sh/release-namespace=$NAMESPACE
    kubectl -n $NAMESPACE label $KIND $NAME app.kubernetes.io/managed-by=Helm
done
