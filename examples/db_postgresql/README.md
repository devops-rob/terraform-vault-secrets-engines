# PostgreSQL with dynamic and static roles Example

### Overview

In this example, the module will be used to enable and configure the database secrets engine for postgresql.  The configuration will include dynamic and static roles for postgresql.

### Postgresql requirements

Vault will require a highly privileged user with root level permissions. Once this user credential was rotated, only the Vault knows the new password. For this reason, it is recommended practice to create a user specifically for Vault.

There will also need to be a readonly role created for this example using the below SQL statements:

```postgresql
CREATE ROLE ro NOINHERIT;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO "ro";
```
### Example use case

Databases often store business critical data, which, if in the wrong hands, could cause real damage to an organisation, both financial and reputational. The risk of data exposure is increased when credentials that provide access to the data is long-lived.

Using Vault, ephemeral credentials can instead be provided to operators and applications.  This reduces the attack surface as credentials, if exposed, have a short TTL and lessens the probability of an accidental or malicious data breach. When the TTL of a credential expires, the credential is revoked. This can be achieved by creating a Vault role.

In order for Vault to perform this function, Vault itself will require a highly privileged long-lived user for the database.  This once again increases the attack surface. To mitigate against that risk, Vault has a Static role, whereby Vault can rotate this long-lived credential and only Vault will know what it is. This allows you to rotate the credential in accordance with your organisation's security policy.

For more information on Vault's Database secrets engine, refer to the following resources:
- [PostgreSQL Database Secrets Engine](https://www.vaultproject.io/docs/secrets/databases/postgresql)
- [PostgreSQL Database Plugin HTTP API](https://www.vaultproject.io/api/secret/databases/postgresql)
- [Database Root Credential Rotation](https://learn.hashicorp.com/tutorials/vault/database-root-rotation)
### Usage

Export the environment variables that contain the Vault token, and the postgresql connection details. Execute the following commands, replacing the variable values to match your environment:
```shell script
export TF_VAR_vault_token=root
export TF_VAR_postgresql_username=root
export TF_VAR_postgresql_password=rootpassword
``` 

Execute the following commands to run the example:
```shell script
terraform init
terraform plan -out=.tfplan
terraform apply .tfplan
```

To test that this secrets engine is working as intended, run the following commands as an authenticated Vault user:

Static role test:
```shell script
vault write -force postgresql/rotate-root/postgresql
```

Dynamic role test:
```shell script
vault read postgresql/creds/readonly
```