variable "pki_backend_maps" {
  type = list(object({
    path                      = string
    default_lease_ttl_seconds = number
    max_lease_ttl_seconds     = number
    seal_wrap                 = bool
    local                     = bool
    external_entropy_access   = bool
    pem_bundle                = string
    issuing_certificates      = list(string)
    crl_distribution_points   = list(string)
    ocsp_servers              = list(string)
  }))
  default     = []
  description = "A list of PKI objects."
}

variable "pki_roles" {
  type = list(object({
    backend               = string
    role_name             = string
    allowed_domains       = list(string)
    allowed_uri_sans      = list(string)
    allow_localhost       = bool
    allow_bare_domains    = bool
    allow_subdomains      = bool
    allow_glob_domains    = bool
    allow_any_name        = bool
    enforce_hostnames     = bool
    allow_ip_sans         = bool
    server_flag           = bool
    client_flag           = bool
    code_signing_flag     = bool
    email_protection_flag = bool
    key_type              = string
    key_bits              = number
    ext_key_usage         = list(string)
    key_usage             = list(string)
    use_csr_common_name   = bool
    use_csr_sans          = bool
    ou                    = list(string)
    organization          = list(string)
    country               = list(string)
    locality              = list(string)
    province              = list(string)
    street_address        = list(string)
    postal_code           = list(string)
    generate_lease        = bool
    no_store              = bool
    require_cn            = bool
    policy_identifiers    = list(string)
  }))
  default     = []
  description = "PKI role objects."
}