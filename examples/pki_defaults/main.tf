provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "pki_defaults" {
  source          = "../../"
  secrets_engines = ["pki"]

  pki_backend_maps = [
    {
      path                      = "dev"
      default_lease_ttl_seconds = 3600
      max_lease_ttl_seconds     = 3600
      seal_wrap                 = false
      local                     = true
      external_entropy_access   = false
    }
  ]
}