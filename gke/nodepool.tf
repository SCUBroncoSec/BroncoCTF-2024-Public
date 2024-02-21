#Node pool
resource "google_container_node_pool" "primaryCluster-nodePool" {
  name     = "${google_container_cluster.primaryCluster.name}-nodepool"
  location = "${var.location}-a"
  cluster  = google_container_cluster.primaryCluster.name

  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = var.node_type

    service_account = google_service_account.cluster-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  depends_on = [google_project_service.enable_apis]
}
