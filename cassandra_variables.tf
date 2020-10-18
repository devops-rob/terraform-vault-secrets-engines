variable "cassandra_path" {
  type        = string
  default     = "cassandra"
  description = "Vault path where the Database secrets engine for Cassandra will be mounted."
}

variable "cassandra_default_lease" {
  type        = number
  default     = 3600
  description = "Default lease for Database secrets engine for cassandra."
}

variable "cassandra_max_lease" {
  type        = number
  default     = 3600
  description = "Maximum lease for Database secrets engine for cassandra."
}

variable "cassandra_seal_wrapping" {
  type        = bool
  default     = true
  description = "Enable seal wrapping for the DB secrets engine for cassandra."
}

variable "cassandra_local_mount" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
}

variable "cassandra_external_entropy_access" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
}

variable "cassandra_allowed_roles" {
  type        = list(string)
  default     = null
  description = "A list of roles that are allowed to use this connection."
}

variable "cassandra_root_rotation_statements" {
  type        = list(string)
  default     = null
  description = "A list of database statements to be executed to rotate the root user's credentials."
}

variable "cassandra_verify_connection" {
  type        = bool
  default     = false
  description = "Whether the connection should be verified on initial configuration or not."
}

variable "cassandra_hosts" {
  type    = list(string)
  default = null
}

variable "cassandra_username" {
  type        = string
  default     = null
  description = "The username to authenticate with."
}

variable "cassandra_password" {
  type        = string
  default     = null
  description = "The password to authenticate with."
}

variable "cassandra_tls" {
  type        = bool
  default     = true
  description = "Whether to use TLS when connecting to Cassandra."
}

variable "cassandra_insecure_tls" {
  type        = bool
  default     = true
  description = "Whether to skip verification of the server certificate when using TLS."
}

variable "cassandra_pem_bundle" {
  type        = string
  default     = null
  description = "Concatenated PEM blocks configuring the certificate chain."
}

variable "cassandra_pem_json" {
  type        = string
  default     = null
  description = "A JSON structure configuring the certificate chain."
}

variable "cassandra_protocol_version" {
  type        = number
  default     = 3
  description = "The CQL protocol version to use."
}

variable "cassandra_connect_timeout" {
  type        = number
  default     = 60
  description = "The number of seconds to use as a connection timeout."
}