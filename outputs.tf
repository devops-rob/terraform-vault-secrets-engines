output "ssh_mount_accessor" {
  value = vault_mount.ssh[*].accessor
}

output "cassandra_mount_accessor" {
  value = vault_mount.cassandra[*].accessor
}

output "mongodb_mount_accessor" {
  value = vault_mount.mongodb[*].accessor
}

output "hana_mount_accessor" {
  value = vault_mount.hana[*].accessor
}

output "mssql_mount_accessor" {
  value = vault_mount.mssql[*].accessor
}

output "mysql_mount_accessor" {
  value = vault_mount.mysql[*].accessor
}

output "postgresql_mount_accessor" {
  value = vault_mount.postgresql[*].accessor
}

output "oracle_mount_accessor" {
  value = vault_mount.oracle[*].accessor
}

output "elasticsearch_mount_accessor" {
  value = vault_mount.elasticsearch[*].accessor
}

output "gcp_role_set_service_account_email" {
  value = vault_gcp_secret_roleset.gcp[*].service_account_email
}

