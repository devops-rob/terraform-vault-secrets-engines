provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}
variable "backend" {
  default = "dev"
}

module "pki_defaults" {
  source          = "../../"
  secrets_engines = ["pki"]

  pki_backend_maps = [
    {
      path                      = var.backend
      default_lease_ttl_seconds = 3600
      max_lease_ttl_seconds     = 3600
      seal_wrap                 = false
      local                     = true
      external_entropy_access   = false
      pem_bundle                = file("${path.module}/pem-bundle.txt")
      issuing_certificates = [
        "http://127.0.0.1:8200/v1/pki/ca"
      ]
      crl_distribution_points = []
      ocsp_servers            = []
      role_name               = "test-role"
    }
  ]

  pki_roles = [
    {
      backend   = var.backend
      role_name = "developers"

      allowed_domains = [
        "localhost",
        "devopsrob.com",
        "hashicorp.com"
      ]

      allowed_uri_sans = [
        "127.0.0.1"
      ]

      allow_localhost       = true
      allow_bare_domains    = true
      allow_subdomains      = false
      allow_glob_domains    = true
      allow_any_name        = false
      enforce_hostnames     = false
      allow_ip_sans         = true
      server_flag           = true
      client_flag           = false
      code_signing_flag     = false
      email_protection_flag = false

      key_type = "rsa"
      key_bits  = 2048
      key_usage = [
        "DigitalSignature",
        "KeyAgreement",
        "KeyEncipherment"
      ]
      ext_key_usage = null

      use_csr_common_name = true
      use_csr_sans        = true

      no_store           = false
      generate_lease     = true
      require_cn         = false
      policy_identifiers = null

      ou             = ["devrel"]
      organization   = ["HashiCorp"]
      country        = null
      locality       = null
      province       = null
      street_address = null
      postal_code    = null
    }
  ]
}