provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

variable "project" {
  default     = "test"
  description = "GCP project name"
}

module "gcp_defaults" {
  source = "../../"

  secrets_engines = ["gcp"]

  gcp_project      = var.project
  gcp_roleset_name = "key-role"
  gcp_credentials  = file("credentials.json")
  gcp_secret_type  = "service_account_key"

  gcp_bindings = [
    {
      resource = "//cloudresourcemanager.googleapis.com/projects/${var.project}"
      roles = [
        "roles/viewer"
      ]
    }
  ]
}
