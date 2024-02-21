# Create resources for remote state
resource "random_id" "bucket_prefix" {
  byte_length = 8
}

data "google_project" "main_project" {
  project_id = var.project_id
}

# KMS Stuff
resource "google_kms_key_ring" "terraform-state" {
  name       = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  location   = "us"
  depends_on = [google_project_service.enable_apis["cloudkms.googleapis.com"]]
}

resource "google_kms_crypto_key" "terraform-state" {
  name            = "terraform-state-bucket"
  key_ring        = google_kms_key_ring.terraform-state.id
  rotation_period = "86400s"

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_project_iam_member" "cryptoKeyEncrypterDecrypter" {
  project = data.google_project.main_project.id
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:service-${data.google_project.main_project.number}@gs-project-accounts.iam.gserviceaccount.com"
}

resource "google_storage_bucket" "remote-state" {
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  encryption {
    default_kms_key_name = google_kms_crypto_key.terraform-state.id
  }
  depends_on = [google_project_iam_member.cryptoKeyEncrypterDecrypter]
}
