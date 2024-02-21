#Service accounts
resource "google_service_account" "cluster-sa" {
  account_id   = "${var.project_id}-cluster-sa"
  display_name = "SA for GKE cluster ${var.project_id}-cluster"
  depends_on   = [google_project_service.enable_apis]
}

#IAM bindings
#Allow image pull from Artifact Registry
resource "google_project_iam_member" "allow_image_pull" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.cluster-sa.email}"
}
#Permissions to write logs/metrics for dashboard
resource "google_project_iam_member" "cluster_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cluster-sa.email}"
}
resource "google_project_iam_member" "cluster_metrics_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.cluster-sa.email}"
}
resource "google_project_iam_member" "cluster_monitoring_viewer" {
  project = var.project_id
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.cluster-sa.email}"
}

resource "google_project_iam_member" "cluster_stackdriver_writer" {
  project = var.project_id
  role    = "roles/stackdriver.resourceMetadata.writer"
  member  = "serviceAccount:${google_service_account.cluster-sa.email}"
}
resource "google_project_iam_member" "cluster_autoscaling_metrics_writer" {
  project = var.project_id
  role    = "roles/autoscaling.metricsWriter"
  member  = "serviceAccount:${google_service_account.cluster-sa.email}"
}

#Cluster
resource "google_container_cluster" "primaryCluster" {
  name     = "${var.project_id}-cluster"
  location = "${var.location}-a"

  #Default node pool, is deleted immedietly and replaced with custom defined node pool
  remove_default_node_pool = true
  initial_node_count       = 1
  depends_on               = [google_project_service.enable_apis]
}
