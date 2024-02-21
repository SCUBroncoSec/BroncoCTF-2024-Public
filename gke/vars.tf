#Config vars
variable "project_id" {
  default = "broncoctf-2024"
}

variable "dns-project-id" {
  default = "broncoctf-dns"
}

variable "location" {
  default = "us-west1"
}

variable "node_type" {
  default = "e2-standard-2"
}

variable "node_count" {
  default = 2
}

variable "dns-service-account-id" {
  default = "external-dns-sa"
}
