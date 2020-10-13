provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

variable "project" {
  default = "test"
}

module "gcp_defaults" {
  source = "../../"

  secrets_engines = ["gcp"]

  gcp_project      = var.project
  gcp_roleset_name = "test"
  gcp_credentials  = file("credentials.json")

  gcp_bindings = [
    {
      resource = "//cloudresourcemanager.googleapis.com/projects/${var.project}"
      roles = [
        "roles/viewer"
      ]
    }
  ]
}
