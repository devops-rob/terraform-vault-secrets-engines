variable "mongodb_path" {
  type        = string
  default     = "mongodb"
  description = "Vault path where the Database secrets engine for mongodb will be mounted."
}

variable "mongodb_default_lease" {
  type        = number
  default     = 3600
  description = "Default lease for Database secrets engine for mongodb."
}

variable "mongodb_max_lease" {
  type        = number
  default     = 3600
  description = "Maximum lease for Database secrets engine for mongodb."
}

variable "mongodb_seal_wrapping" {
  type        = bool
  default     = true
  description = "Enable seal wrapping for the DB secrets engine for mongodb."
}

variable "mongodb_local_mount" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
}

variable "mongodb_external_entropy_access" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
}

variable "mongodb_allowed_roles" {
  type        = list(string)
  default     = null
  description = "A list of roles that are allowed to use this connection."
}

variable "mongodb_root_rotation_statements" {
  type        = list(string)
  default     = null
  description = "A list of database statements to be executed to rotate the root user's credentials."
}

variable "mongodb_verify_connection" {
  type        = bool
  default     = false
  description = "Whether the connection should be verified on initial configuration or not."
}

variable "mongodb_connection_endpoint" {
  type        = string
  default     = "localhost:27017"
  description = "A URL containing connection information."
}
variable "mongodb_tls" {
  type        = string
  default     = "false"
  description = "Whether mongodb connection should use tls. Valid arguments are 'true' or 'false'."
}

variable "mongodb_max_connection_lifetime" {
  type        = number
  default     = 360
  description = "The maximum number of seconds to keep a connection alive for."
}

variable "mongodb_max_idle_connections" {
  type        = number
  default     = 360
  description = "The maximum number of idle connections to maintain."
}

variable "mongodb_max_open_connections" {
  type        = number
  default     = 360
  description = "The maximum number of open connections to use."
}

variable "mongodb_username" {
  type        = string
  default     = null
  description = "Username for MongoDB."
}

variable "mongodb_password" {
  type        = string
  default     = null
  description = "Password for MongoDB."
}

