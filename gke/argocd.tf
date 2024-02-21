/*************
 * ARGOCD.TF *
 *************/
# Installs and bootstraps ArgoCD onto the GKE cluster

# Create argocd namespace
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

# Apply argocd kustomization
module "argocd-install" {
  source = "kbst.xyz/catalog/custom-manifests/kustomization"

  configuration_base_key = "default"
  configuration = {
    default = {
      resources = [
        "../k8s-resources/argocd/"
      ]
    }
  }
  depends_on = [kubectl_manifest.externaldns-install]
}
