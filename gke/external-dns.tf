/*******************
 * EXTERNAL-DNS.TF *
 *******************/
# Bootstraps external-dns by creating the necessary GCP resources, then appling k8s manifests

# Create a service account (with permissions) for external-dns to use
resource "google_service_account" "externaldns-sa" {
  account_id   = var.dns-service-account-id
  display_name = var.dns-service-account-id
}

resource "google_project_iam_binding" "external-dns-sa-binding" {
  depends_on = [
    google_service_account.externaldns-sa
  ]

  project = var.dns-project-id
  role    = "roles/dns.admin"

  members = ["serviceAccount:${google_service_account.externaldns-sa.email}"]
}

# Create a namespace for external-dns
resource "kubernetes_namespace" "external-dns" {
  metadata {
    name = "external-dns"
  }
}

# Install external-dns through provided manifests
resource "kubectl_manifest" "externaldns-install" {
  for_each = fileset(path.module, "../k8s-resources/external-dns/*.yaml")

  yaml_body          = file(each.value)
  override_namespace = "external-dns"
  depends_on         = [kubernetes_namespace.external-dns]
}
# Give external-dns credentials for it's service accoun t
resource "google_service_account_key" "externaldns-sa-key" {
  service_account_id = google_service_account.externaldns-sa.account_id
}

resource "kubernetes_secret" "externaldns-secret" {
  depends_on = [
    google_service_account_key.externaldns-sa-key,
    google_container_cluster.primaryCluster,
    kubernetes_namespace.external-dns
  ]

  metadata {
    name      = "external-dns"
    namespace = "external-dns"
  }

  data = {
    "credentials.json" = base64decode(google_service_account_key.externaldns-sa-key.private_key)
  }
}
