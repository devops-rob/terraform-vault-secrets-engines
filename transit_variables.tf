variable "transit_cache_size" {
  type        = number
  default     = 0
  description = "The number of cache entries. 0 means unlimited"
}

variable "transit_keys" {
  type = list(object({
    name                   = string
    type                   = string
    deletion_allowed       = bool
    derived                = bool
    convergent_encryption  = bool
    exportable             = bool
    allow_plaintext_backup = bool
    min_decryption_version = number
    min_encryption_version = number
  }))
  default = null
  description = "A list of transit key objects."
}

locals {
  keys = var.transit_keys
}