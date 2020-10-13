provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

locals {
  project = "test"
}
module "gcp_defaults" {
  source = "../../"

  secrets_engines = ["gcp"]

  gcp_project      = local.project
  gcp_roleset_name = "test"
  gcp_credentials  = file("credentials.json")

  gcp_bindings = [
    {
      resource = "//cloudresourcemanager.googleapis.com/projects/${local.project}"
      roles = [
        "roles/viewer"
      ]
    }
  ]
}
