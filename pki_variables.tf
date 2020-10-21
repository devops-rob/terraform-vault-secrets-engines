//variable "pki_backends" {
//  type        = list(string)
//  default     = null
//  description = "A list of PKI secret backends."
//}
//
//variable "pki_default_lease" {
//  type        = number
//  default     = 3600
//  description = "The default TTL for credentials issued by this backend."
//}
//
//variable "pki_max_lease" {
//  type        = number
//  default     = 3600
//  description = "The maximum TTL that can be requested for credentials issued by this backend."
//}
//
//variable "pki_seal_wrap" {
//  type        = bool
//  default     = true
//  description = "Enable seal wrapping for secrets engines."
//}
//
//variable "pki_local_mount" {
//  type        = bool
//  default     = true
//  description = "Boolean flag that can be explicitly set to true to enforce local mount in HA environment."
//}
//
//variable "pki_external_entropy_access" {
//  type        = bool
//  default     = false
//  description = "Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source."
//}


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