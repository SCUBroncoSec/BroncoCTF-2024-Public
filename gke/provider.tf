terraform {
  backend "gcs" {
    bucket = "c3aa580d4c9b12ef-bucket-tfstate"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
    }
    kustomization = {
      source = "kbst/kustomization"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.location
}
data "google_client_config" "default" {}

provider "kubernetes" {
  host = "https://${google_container_cluster.primaryCluster.endpoint}"

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primaryCluster.master_auth[0].cluster_ca_certificate)
}

provider "kubectl" {
  load_config_file = false

  host = "https://${google_container_cluster.primaryCluster.endpoint}"

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primaryCluster.master_auth[0].cluster_ca_certificate)
}

provider "kustomization" {
  kubeconfig_raw = yamlencode({
    apiVersion      = "v1"
    kind            = "Config"
    preferences     = {}
    current-context = "default"
    clusters = [
      {
        name = "default"
        cluster = {
          certificate-authority-data = google_container_cluster.primaryCluster.master_auth[0].cluster_ca_certificate
          server                     = "https://${google_container_cluster.primaryCluster.endpoint}"
        }
      }
    ]
    users = [
      {
        name = "default"
        user = {
          token = data.google_client_config.default.access_token
        }
      }
    ]
    contexts = [
      {
        name = "default"
        context = {
          cluster = "default"
          user    = "default"
        }
      }
    ]
  })
}
