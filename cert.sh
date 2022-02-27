# crds=("certificaterequests.cert-manager.io" "certificates.cert-manager.io" "challenges.acme.cert-manager.io" "clusterissuers.cert-manager.io" "issuers.cert-manager.io" "orders.acme.cert-manager.io")

# for crd in "${crds}"; do
#   manager_index="$(kubectl get crd "${crd}" --show-managed-fields --output json | jq -r '.metadata.managedFields | map(.manager == "cainjector") | index(true)')"
#   kubectl --kubeconfig=.config/kubeconfig patch crd "${crd}" --type=json -p="[{\"op\": \"remove\", \"path\": \"/metadata/managedFields/${manager_index}\"}]"
# done
for crd_name in certificaterequests.cert-manager.io certificates.cert-manager.io challenges.acme.cert-manager.io clusterissuers.cert-manager.io issuers.cert-manager.io orders.acme.cert-manager.io; do
  manager_index="$(kubectl --kubeconfig=.config/kubeconfig get crd "${crd_name}" --show-managed-fields --output json | jq -r '.metadata.managedFields | map(.manager == "cainjector") | index(true)')"
  kubectl --kubeconfig=.config/kubeconfig patch crd "${crd_name}" --type=json -p="[{\"op\": \"remove\", \"path\": \"/metadata/managedFields/${manager_index}\"}]"
done
