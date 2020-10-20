variable "databases" {
  type        = list(string)
  default     = null
  description = "List of database secrets engines to enable."
}

variable "db_roles" {
  type = list(object({
    backend               = string
    name                  = string
    db_name               = string
    creation_statements   = list(string)
    revocation_statements = list(string)
    renew_statements      = list(string)
    rollback_statements   = list(string)
    default_ttl           = number
    max_ttl               = number
  }))
  default     = []
  description = "A list of database role objects."
}

variable "db_static_roles" {
  type = list(object({
    backend             = string
    name                = string
    db_name             = string
    username            = string
    rotation_statements = list(string)
    rotation_period     = number
  }))
  default     = []
  description = "A list of database static role objects."
}
