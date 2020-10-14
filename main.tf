resource "vault_mount" "ssh" {
  count = contains(var.secrets_engines, "ssh") ? 1 : 0
  path  = "ssh"
  type  = "ssh"

  default_lease_ttl_seconds = var.default_lease
  max_lease_ttl_seconds     = var.max_lease

  seal_wrap               = var.seal_wrap
  local                   = var.local_mount
  external_entropy_access = var.external_entropy_access

  description = "The ssh secrets engine is mounted at the ssh/ path"
}

resource "vault_mount" "db" {
  count = contains(var.secrets_engines, "db") ? 1 : 0
  path  = "db"
  type  = "db"

  default_lease_ttl_seconds = var.default_lease
  max_lease_ttl_seconds     = var.max_lease

  seal_wrap               = var.seal_wrap
  local                   = var.local_mount
  external_entropy_access = var.external_entropy_access

  description = "The ${element(var.secrets_engines, count.index)} secrets engine is mounted at the /${element(var.secrets_engines, count.index)} path"
}

resource "vault_mount" "transit" {
  count = contains(var.secrets_engines, "transit") ? 1 : 0
  path  = "transit"
  type  = "transit"

  default_lease_ttl_seconds = var.default_lease
  max_lease_ttl_seconds     = var.max_lease

  seal_wrap               = var.seal_wrap
  local                   = var.local_mount
  external_entropy_access = var.external_entropy_access

  description = "The ${element(var.secrets_engines, count.index)} secrets engine is mounted at the /${element(var.secrets_engines, count.index)} path"
}

resource "vault_transit_secret_cache_config" "transit" {
  count   = contains(var.secrets_engines, "transit") ? 1 : 0
  backend = vault_mount.transit[count.index].path
  size    = var.transit_cache_size
}

resource "vault_transit_secret_backend_key" "transit" {
  for_each = {
    for key in var.transit_keys :
    key.name => key
  }

  backend = "transit"

  name                   = each.value["name"]
  type                   = each.value["type"]
  deletion_allowed       = each.value["deletion_allowed"]
  derived                = each.value["derived"]
  convergent_encryption  = each.value["convergent_encryption"]
  exportable             = each.value["exportable"]
  allow_plaintext_backup = each.value["allow_plaintext_backup"]
  min_decryption_version = each.value["min_decryption_version"]
  min_encryption_version = each.value["min_encryption_version"]

  depends_on = [
    vault_mount.transit
  ]
}
resource "vault_aws_secret_backend" "aws_backend" {
  count = contains(var.secrets_engines, "aws") ? 1 : 0

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region

  default_lease_ttl_seconds = var.aws_default_lease
  max_lease_ttl_seconds     = var.aws_max_lease
}

resource "vault_aws_secret_backend_role" "aws_backend_role" {
  count = contains(var.secrets_engines, "aws") ? 1 : 0
  name  = var.aws_backend_role_name

  backend         = vault_aws_secret_backend.aws_backend[count.index].path
  credential_type = var.aws_backend_role_cred_type

  role_arns       = var.aws_role_arns
  policy_arns     = var.aws_policy_arns
  policy_document = var.aws_policy_document
  iam_groups      = var.aws_iam_groups

  default_sts_ttl = var.aws_sts_default_ttl
  max_sts_ttl     = var.aws_sts_max_ttl
}

resource "vault_azure_secret_backend" "azure_secret_backend" {
  count = contains(var.secrets_engines, "azure") ? 1 : 0
  path  = "azure"

  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id

  client_id     = var.azure_client_id
  client_secret = var.azure_client_secret
  environment   = var.azure_environment
}

resource "vault_azure_secret_backend_role" "azure_secret_backend_role" {
  count = contains(var.secrets_engines, "azure") ? 1 : 0
  role  = var.azure_secret_backend_role_name

  backend = vault_azure_secret_backend.azure_secret_backend[count.index].path
  max_ttl = var.azure_secret_backend_max_ttl
  ttl     = var.azure_secret_backend_ttl

  azure_roles {
    role_name = var.azure_role
    scope     = local.azure_role_scope
  }

  application_object_id = var.azure_app_id
}

resource "vault_consul_secret_backend" "consul" {
  count = contains(var.secrets_engines, "consul") ? 1 : 0
  path  = "consul"

  address = var.consul_address
  scheme  = local.scheme
  token   = var.consul_token

  default_lease_ttl_seconds = var.consul_default_lease
  max_lease_ttl_seconds     = var.consul_max_lease
}

resource "vault_consul_secret_backend_role" "consul" {
  count   = contains(var.secrets_engines, "consul") ? 1 : 0
  name    = var.consul_backend_role_name
  backend = vault_consul_secret_backend.consul[count.index].path

  policies   = var.consul_policies
  local      = var.consul_local_token
  token_type = var.consul_token_type

  ttl     = var.consul_default_lease
  max_ttl = var.consul_max_lease
}

resource "vault_rabbitmq_secret_backend" "rabbitmq" {
  count = contains(var.secrets_engines, "rabbitmq") ? 1 : 0
  path  = "rabbitmq"

  connection_uri    = var.rabbitmq_uri
  password          = var.rabbitmq_password
  username          = var.rabbitmq_username
  verify_connection = var.rabbitmq_verify_connection

  default_lease_ttl_seconds = var.rabbitmq_default_ttl
  max_lease_ttl_seconds     = var.rabbitmq_maximum_ttl
}

resource "vault_rabbitmq_secret_backend_role" "rabbitmq" {
  count   = contains(var.secrets_engines, "rabbitmq") ? 1 : 0
  backend = vault_rabbitmq_secret_backend.rabbitmq[count.index].path
  name    = var.rabbitmq_backend_role_name

  vhost {
    configure = var.rabbitmq_configure_permissions
    host      = var.rabbitmq_vhost
    read      = var.rabbitmq_read_permissions
    write     = var.rabbitmq_write_permissions
  }

  tags = var.rabbitmq_tags
}

resource "vault_ssh_secret_backend_ca" "ssh" {
  count   = contains(var.secrets_engines, "ssh") ? 1 : 0
  backend = vault_mount.ssh[count.index].path

  generate_signing_key = var.ssh_generate_signing_key
  private_key          = var.ssh_private_key
  public_key           = var.ssh_public_key
}

resource "vault_ssh_secret_backend_role" "ssh" {
  count   = contains(var.secrets_engines, "ssh") ? 1 : 0
  backend = vault_ssh_secret_backend_ca.ssh[count.index].backend
  name    = var.ssh_backend_role_name

  key_type = var.ssh_key_type
  max_ttl  = var.ssh_max_ttl
  ttl      = var.ssh_default_ttl

  allow_bare_domains      = var.ssh_allow_bare_domains
  allow_host_certificates = var.ssh_allow_host_certificates
  allow_subdomains        = var.ssh_allow_subdomains
  allow_user_certificates = var.ssh_allow_user_certificates
  allow_user_key_ids      = var.ssh_allow_user_key_ids

  allowed_critical_options = var.ssh_allowed_critical_options
  allowed_domains          = var.ssh_allowed_domains
  allowed_extensions       = var.ssh_allowed_extensions
  allowed_users            = var.ssh_allowed_users

  allowed_user_key_lengths = var.ssh_allowed_user_key_lengths
  default_extensions       = var.ssh_default_extensions
  default_critical_options = var.ssh_default_extensions

  cidr_list     = var.ssh_cidr_list
  default_user  = var.ssh_default_user
  key_id_format = var.ssh_key_id_format
}

resource "vault_gcp_secret_backend" "gcp" {
  count = contains(var.secrets_engines, "gcp") ? 1 : 0
  path  = "gcp"

  default_lease_ttl_seconds = var.gcp_default_ttl
  max_lease_ttl_seconds     = var.gcp_maximum_ttl
  credentials               = var.gcp_credentials
}

resource "vault_gcp_secret_roleset" "gcp" {
  count   = contains(var.secrets_engines, "gcp") ? 1 : 0
  backend = vault_gcp_secret_backend.gcp[count.index].path

  project = var.gcp_project
  roleset = var.gcp_roleset_name

  dynamic "binding" {
    for_each = var.gcp_bindings
    content {
      resource = binding.value["resource"]
      roles    = binding.value["roles"]
    }
  }

  secret_type  = var.gcp_secret_type
  token_scopes = var.gcp_token_scopes
}