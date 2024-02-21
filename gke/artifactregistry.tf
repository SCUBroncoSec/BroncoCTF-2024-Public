resource "google_artifact_registry_repository" "docker" {
  location      = "us-west1"
  repository_id = "broncoctf-2024"
  description   = "Docker images for BroncoCTF 2024"
  format        = "DOCKER"
}
