resource "vault_mount" "pki" {
  for_each = {
    for mount in var.pki_backend_maps :
    mount.path => mount
  }

  path = each.value["path"]
  type = "pki"


  default_lease_ttl_seconds = each.value["default_lease_ttl_seconds"]
  max_lease_ttl_seconds     = each.value["max_lease_ttl_seconds"]

  seal_wrap               = each.value["seal_wrap"]
  local                   = each.value["local"]
  external_entropy_access = each.value["external_entropy_access"]

  description = "PKI secrets backend environment for ${each.value["path"]} environmet"

}

resource "vault_pki_secret_backend_config_ca" "pki" {
  for_each = {
    for mount in var.pki_backend_maps :
    mount.path => mount
  }

  backend    = each.value["path"]
  pem_bundle = each.value["pem_bundle"]

  depends_on = [
    vault_mount.pki
  ]
}

resource "vault_pki_secret_backend_config_urls" "pki" {
  for_each = {
    for mount in var.pki_backend_maps :
    mount.path => mount
  }

  backend                 = each.value["path"]
  issuing_certificates    = each.value["issuing_certificates"]
  crl_distribution_points = each.value["crl_distribution_points"]
  ocsp_servers            = each.value["ocsp_servers"]

  depends_on = [
    vault_mount.pki
  ]

}

resource "vault_pki_secret_backend_role" "pki" {
  for_each = {
    for role in var.pki_roles :
    role.role_name => role
  }

  backend = each.value["backend"]
  name    = each.value["role_name"]

  allowed_domains  = each.value["allowed_domains"]
  allowed_uri_sans = each.value["allowed_uri_sans"]

  allow_localhost    = each.value["allow_localhost"]
  allow_bare_domains = each.value["allow_bare_domains"]
  allow_subdomains   = each.value["allow_subdomains"]
  allow_glob_domains = each.value["allow_glob_domains"]
  allow_any_name     = each.value["allow_any_name"]
  enforce_hostnames  = each.value["enforce_hostnames"]
  allow_ip_sans      = each.value["allow_ip_sans"]

  server_flag           = each.value["server_flag"]
  client_flag           = each.value["client_flag"]
  code_signing_flag     = each.value["code_signing_flag"]
  email_protection_flag = each.value["email_protection_flag"]

  key_type      = each.value["key_type"]
  key_bits      = each.value["key_bits"]
  ext_key_usage = each.value["ext_key_usage"]
  key_usage     = each.value["key_usage"]

  use_csr_common_name = each.value["use_csr_common_name"]
  use_csr_sans        = each.value["use_csr_sans"]

  ou             = each.value["ou"]
  organization   = each.value["organization"]
  country        = each.value["country"]
  locality       = each.value["locality"]
  province       = each.value["province"]
  street_address = each.value["street_address"]
  postal_code    = each.value["postal_code"]

  generate_lease = each.value["generate_lease"]
  no_store       = each.value["no_store"]
  require_cn     = each.value["require_cn"]

  policy_identifiers = each.value["policy_identifiers"]

  depends_on = [
    vault_mount.pki
  ]

}

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

resource "vault_mount" "cassandra" {
  count = contains(var.databases, "cassandra") ? 1 : 0
  path  = var.cassandra_path
  type  = "database"

  default_lease_ttl_seconds = var.cassandra_default_lease
  max_lease_ttl_seconds     = var.cassandra_max_lease

  seal_wrap               = var.cassandra_seal_wrapping
  local                   = var.cassandra_local_mount
  external_entropy_access = var.cassandra_external_entropy_access

  description = "The database secrets engine for Cassandra is mounted at the ${element(var.secrets_engines, count.index)}/ path"
}


resource "vault_database_secret_backend_connection" "cassandra" {
  count   = contains(var.databases, "cassandra") ? 1 : 0
  backend = vault_mount.cassandra[count.index].path

  name                     = "cassandra"
  allowed_roles            = var.cassandra_allowed_roles
  root_rotation_statements = var.cassandra_root_rotation_statements

  cassandra {
    hosts    = var.cassandra_hosts
    username = var.cassandra_username
    password = var.cassandra_password

    tls          = var.cassandra_tls
    insecure_tls = var.cassandra_insecure_tls
    pem_bundle   = var.cassandra_pem_bundle
    pem_json     = var.cassandra_pem_json

    protocol_version = var.cassandra_protocol_version
    connect_timeout  = var.cassandra_connect_timeout

  }

  verify_connection = var.cassandra_verify_connection

  depends_on = [
    vault_mount.cassandra
  ]
}

resource "vault_mount" "mongodb" {
  count = contains(var.databases, "mongodb") ? 1 : 0
  path  = var.mongodb_path
  type  = "database"

  default_lease_ttl_seconds = var.mongodb_default_lease
  max_lease_ttl_seconds     = var.mongodb_max_lease

  seal_wrap               = var.mongodb_seal_wrapping
  local                   = var.mongodb_local_mount
  external_entropy_access = var.mongodb_external_entropy_access

  description = "The database secrets engine for MongoDB is mounted at the ${element(var.secrets_engines, count.index)}/ path"
}

resource "vault_database_secret_backend_connection" "mongodb" {
  count   = contains(var.databases, "mongodb") ? 1 : 0
  backend = vault_mount.mongodb[count.index].path

  name                     = "mongodb"
  allowed_roles            = var.mongodb_allowed_roles
  root_rotation_statements = var.mongodb_root_rotation_statements

  mongodb {
    connection_url          = "mongodb://{{username}}:{{password}}@${var.mongodb_connection_endpoint}/admin?tls=${var.mongodb_tls}"
    max_connection_lifetime = var.mongodb_max_connection_lifetime
    max_idle_connections    = var.mongodb_max_idle_connections
    max_open_connections    = var.mongodb_max_open_connections
  }

  data = {
    username = var.mongodb_username
    password = var.mongodb_password
  }

  verify_connection = var.mongodb_verify_connection
}

resource "vault_mount" "hana" {
  count = contains(var.databases, "hana") ? 1 : 0
  path  = var.hana_path
  type  = "database"

  default_lease_ttl_seconds = var.hana_default_lease
  max_lease_ttl_seconds     = var.hana_max_lease

  seal_wrap               = var.hana_seal_wrapping
  local                   = var.hana_local_mount
  external_entropy_access = var.hana_external_entropy_access

  description = "The database secrets engine for hana is mounted at the ${element(var.secrets_engines, count.index)}/ path"
}

resource "vault_database_secret_backend_connection" "hana" {
  count   = contains(var.databases, "hana") ? 1 : 0
  backend = vault_mount.hana[count.index].path

  name                     = "hana"
  allowed_roles            = var.hana_allowed_roles
  root_rotation_statements = var.hana_root_rotation_statements

  hana {
    connection_url          = var.hana_connection_url
    max_connection_lifetime = var.hana_max_connection_lifetime
    max_idle_connections    = var.hana_max_idle_connections
    max_open_connections    = var.hana_max_open_connections
  }
  verify_connection = var.hana_verify_connection
}

resource "vault_mount" "mssql" {
  count = contains(var.databases, "mssql") ? 1 : 0
  path  = var.mssql_path
  type  = "database"

  default_lease_ttl_seconds = var.mssql_default_lease
  max_lease_ttl_seconds     = var.mssql_max_lease

  seal_wrap               = var.mssql_seal_wrapping
  local                   = var.mssql_local_mount
  external_entropy_access = var.mssql_external_entropy_access

  description = "The database secrets engine for mssql is mounted at the ${element(var.secrets_engines, count.index)}/ path"
}

resource "vault_database_secret_backend_connection" "mssql" {
  count   = contains(var.databases, "mssql") ? 1 : 0
  backend = vault_mount.mssql[count.index].path

  name                     = "mssql"
  allowed_roles            = var.mssql_allowed_roles
  root_rotation_statements = var.mssql_root_rotation_statements

  mssql {
    connection_url          = var.mssql_connection_url
    max_connection_lifetime = var.mssql_max_connection_lifetime
    max_idle_connections    = var.mssql_max_idle_connections
    max_open_connections    = var.mssql_max_open_connections
  }
  verify_connection = var.mssql_verify_connection
}

resource "vault_mount" "mysql" {
  count = contains(var.databases, "mysql") ? 1 : 0
  path  = var.mysql_path
  type  = "database"

  default_lease_ttl_seconds = var.mysql_default_lease
  max_lease_ttl_seconds     = var.mysql_max_lease

  seal_wrap               = var.mysql_seal_wrapping
  local                   = var.mysql_local_mount
  external_entropy_access = var.mysql_external_entropy_access

  description = "The database secrets engine for mysql is mounted at the ${element(var.secrets_engines, count.index)}/ path"
}

resource "vault_database_secret_backend_connection" "mysql" {
  count   = contains(var.databases, "mysql") ? 1 : 0
  backend = vault_mount.mysql[count.index].path

  name                     = "mysql"
  allowed_roles            = var.mysql_allowed_roles
  root_rotation_statements = var.mysql_root_rotation_statements

  mysql {
    connection_url          = "{{username}}:{{password}}@tcp(${var.mysql_connection_endpoint})/"
    max_connection_lifetime = var.mysql_max_connection_lifetime
    max_idle_connections    = var.mysql_max_idle_connections
    max_open_connections    = var.mysql_max_open_connections
  }
  verify_connection = var.mysql_verify_connection

  data = {
    username = var.mysql_username
    password = var.mysql_password
  }

  depends_on = [vault_mount.mysql]
}

resource "vault_mount" "postgresql" {
  count = contains(var.databases, "postgresql") ? 1 : 0
  path  = var.postgresql_path
  type  = "database"

  default_lease_ttl_seconds = var.postgresql_default_lease
  max_lease_ttl_seconds     = var.postgresql_max_lease

  seal_wrap               = var.postgresql_seal_wrapping
  local                   = var.postgresql_local_mount
  external_entropy_access = var.postgresql_external_entropy_access

  description = "The database secrets engine for postgresql is mounted at the ${element(var.secrets_engines, count.index)}/ path"
}

resource "vault_database_secret_backend_connection" "postgresql" {
  count   = contains(var.databases, "postgresql") ? 1 : 0
  backend = vault_mount.postgresql[count.index].path

  name                     = "postgresql"
  allowed_roles            = var.postgresql_allowed_roles
  root_rotation_statements = var.postgresql_root_rotation_statements

  postgresql {
    connection_url          = "postgresql://{{username}}:{{password}}@${var.postgresql_connection_endpoint}/postgres?sslmode=${var.postgresql_sslmode}"
    max_connection_lifetime = var.postgresql_max_connection_lifetime
    max_idle_connections    = var.postgresql_max_idle_connections
    max_open_connections    = var.postgresql_max_open_connections
  }
  verify_connection = var.postgresql_verify_connection

  data = {
    username = var.postgresql_username
    password = var.postgresql_password
  }

  depends_on = [
    vault_mount.postgresql
  ]
}

resource "vault_mount" "oracle" {
  count = contains(var.databases, "oracle") ? 1 : 0
  path  = var.oracle_path
  type  = "database"

  default_lease_ttl_seconds = var.oracle_default_lease
  max_lease_ttl_seconds     = var.oracle_max_lease

  seal_wrap               = var.oracle_seal_wrapping
  local                   = var.oracle_local_mount
  external_entropy_access = var.oracle_external_entropy_access

  description = "The database secrets engine for oracle is mounted at the ${element(var.secrets_engines, count.index)}/ path"
}

resource "vault_database_secret_backend_connection" "oracle" {
  count   = contains(var.databases, "oracle") ? 1 : 0
  backend = vault_mount.oracle[count.index].path

  name                     = "oracle"
  allowed_roles            = var.oracle_allowed_roles
  root_rotation_statements = var.oracle_root_rotation_statements

  oracle {
    connection_url          = var.oracle_connection_url
    max_connection_lifetime = var.oracle_max_connection_lifetime
    max_idle_connections    = var.oracle_max_idle_connections
    max_open_connections    = var.oracle_max_open_connections
  }
  verify_connection = var.oracle_verify_connection
}

resource "vault_mount" "elasticsearch" {
  count = contains(var.databases, "elasticsearch") ? 1 : 0
  path  = var.elasticsearch_path
  type  = "database"

  default_lease_ttl_seconds = var.elasticsearch_default_lease
  max_lease_ttl_seconds     = var.elasticsearch_max_lease

  seal_wrap               = var.elasticsearch_seal_wrapping
  local                   = var.elasticsearch_local_mount
  external_entropy_access = var.elasticsearch_external_entropy_access

  description = "The database secrets engine for elasticsearch is mounted at the ${element(var.secrets_engines, count.index)}/ path"
}

resource "vault_database_secret_backend_connection" "elasticsearch" {
  count   = contains(var.databases, "elasticsearch") ? 1 : 0
  backend = vault_mount.elasticsearch[count.index].path

  name                     = "elasticsearch"
  allowed_roles            = var.elasticsearch_allowed_roles
  root_rotation_statements = var.elasticsearch_root_rotation_statements

  elasticsearch {
    url      = var.elasticsearch_url
    username = var.elasticsearch_username
    password = var.elasticsearch_password
  }
  verify_connection = var.elasticsearch_verify_connection
}


resource "vault_database_secret_backend_role" "roles" {
  for_each = {
    for role in var.db_roles :
    role.name => role
  }

  backend = each.value["backend"]
  db_name = each.value["db_name"]
  name    = each.value["name"]

  creation_statements   = each.value["creation_statements"]
  revocation_statements = each.value["revocation_statements"]
  renew_statements      = each.value["renew_statements"]
  rollback_statements   = each.value["rollback_statements"]

  default_ttl = each.value["default_ttl"]
  max_ttl     = each.value["max_ttl"]

  depends_on = [
    vault_mount.mysql,
    vault_mount.mongodb,
    vault_mount.elasticsearch,
    vault_mount.oracle,
    vault_mount.postgresql,
    vault_mount.mssql,
    vault_mount.hana,
    vault_mount.mongodb,
    vault_mount.cassandra,
    vault_database_secret_backend_connection.cassandra,
    vault_database_secret_backend_connection.elasticsearch,
    vault_database_secret_backend_connection.hana,
    vault_database_secret_backend_connection.mongodb,
    vault_database_secret_backend_connection.mssql,
    vault_database_secret_backend_connection.mysql,
    vault_database_secret_backend_connection.oracle,
  ]

}

resource "vault_database_secret_backend_static_role" "roles" {
  for_each = {
    for role in var.db_static_roles :
    role.name => role
  }

  backend = each.value["backend"]
  db_name = each.value["db_name"]
  name    = each.value["name"]

  rotation_statements = each.value["rotation_statements"]
  rotation_period     = each.value["rotation_period"]
  username            = each.value["username"]

  depends_on = [
    vault_mount.mysql,
    vault_mount.mongodb,
    vault_mount.elasticsearch,
    vault_mount.oracle,
    vault_mount.postgresql,
    vault_mount.mssql,
    vault_mount.hana,
    vault_mount.mongodb,
    vault_mount.cassandra,
    vault_database_secret_backend_connection.cassandra
  ]
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