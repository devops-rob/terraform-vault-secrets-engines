variable "mssql_path" {
  type        = string
  default     = "mssql"
  description = "Vault path where the Database secrets engine for mssql will be mounted."
}

variable "mssql_default_lease" {
  type        = number
  default     = 3600
  description = "Default lease for Database secrets engine for mssql."
}

variable "mssql_max_lease" {
  type        = number
  default     = 3600
  description = "Maximum lease for Database secrets engine for mssql."
}

variable "mssql_seal_wrapping" {
  type        = bool
  default     = true
  description = "Enable seal wrapping for the DB secrets engine for mssql."
}

variable "mssql_local_mount" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
}

variable "mssql_external_entropy_access" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
}

variable "mssql_allowed_roles" {
  type        = list(string)
  default     = null
  description = "A list of roles that are allowed to use this connection."
}

variable "mssql_root_rotation_statements" {
  type        = list(string)
  default     = null
  description = "A list of database statements to be executed to rotate the root user's credentials."
}

variable "mssql_verify_connection" {
  type        = bool
  default     = false
  description = "Whether the connection should be verified on initial configuration or not."
}

variable "mssql_connection_url" {
  type        = string
  default     = "localhost:1433"
  description = "A URL containing connection information."
}

variable "mssql_max_connection_lifetime" {
  type        = number
  default     = 360
  description = "The maximum number of seconds to keep a connection alive for."
}

variable "mssql_max_idle_connections" {
  type        = number
  default     = 360
  description = "The maximum number of idle connections to maintain."
}

variable "mssql_max_open_connections" {
  type        = number
  default     = 360
  description = "The maximum number of open connections to use."
}


