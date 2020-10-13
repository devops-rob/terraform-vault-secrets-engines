variable "gcp_default_ttl" {
  type        = number
  default     = 3600
  description = "Default TTL for GCP secrets backend."
}

variable "gcp_maximum_ttl" {
  type        = number
  default     = 3600
  description = "Maximum TTL for GCP secrets backend."
}

variable "gcp_credentials" {
  description = "The GCP service account credentials in JSON format."
  default     = null
}

variable "gcp_project" {
  type        = string
  default     = null
  description = "Name of the GCP project that this roleset's service account will belong to."
}

variable "gcp_roleset_name" {
  type        = string
  default     = null
  description = "Name of the Roleset to create."
}

variable "gcp_secret_type" {
  type        = string
  default     = "access_token"
  description = "Type of secret generated for this role set. Accepted values: access_token, service_account_key."
}

variable "gcp_token_scopes" {
  type = list(string)
  default = [
    "https://www.googleapis.com/auth/cloud-platform"
  ]
  description = "List of OAuth scopes to assign to access_token secrets generated under this role set."
}

variable "gcp_bindings" {
  type = list(object({
    resource = string
    roles    = list(string)
  }))
  description = "Bindings to create for this roleset. This can be specified multiple times for multiple bindings."
}

