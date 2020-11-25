# cassandra with dynamic and static roles Example

### Overview

In this example, the module will be used to enable and configure the database secrets engine for cassandra.  The configuration will include dynamic and static roles for cassandra.

### cassandra requirements

Vault will require a highly privileged user with root level permissions. Once this user credential was rotated, only the Vault knows the new password. For this reason, it is recommended practice to create a user specifically for Vault.

The cassandra.yaml file will also need some default settings changed.

The authenticator cannot be set to "AllowAllAuthenticator". Instead, set this to "PasswordAuthenticator", or delegate authentication using DSE.
The authorizer also should not be set to "AllowAllAuthorizer". Instead, consider setting this to "CassandraAuthorizer".

For more information regarding the security model of Cassandra, refer to the [Security Documentation.](https://cassandra.apache.org/doc/latest/operating/security.html)

### Example use case

Databases often store business critical data, which, if in the wrong hands, could cause real damage to an organisation, both financial and reputational. The risk of data exposure is increased when credentials that provide access to the data is long-lived.

Using Vault, ephemeral credentials can instead be provided to operators and applications.  This reduces the attack surface as credentials, if exposed, have a short TTL and lessens the probability of an accidental or malicious data breach. When the TTL of a credential expires, the credential is revoked. This can be achieved by creating a Vault role.

In order for Vault to perform this function, Vault itself will require a highly privileged long-lived user for the database.  This once again increases the attack surface. To mitigate against that risk, Vault has a Static role, whereby Vault can rotate this long-lived credential and only Vault will know what it is. This allows you to rotate the credential in accordance with your organisation's security policy.

For more information on Vault's Database secrets engine, refer to the following resources:
- [cassandra Database Secrets Engine](https://www.vaultproject.io/docs/secrets/databases/cassandra)
- [cassandra Database Plugin HTTP API](https://www.vaultproject.io/api/secret/databases/cassandra)
- [Database Root Credential Rotation](https://learn.hashicorp.com/tutorials/vault/database-root-rotation)
### Usage

Export the environment variables that contain the Vault token, and the cassandra connection details. Execute the following commands, replacing the variable values to match your environment:
```shell script
export TF_VAR_vault_token=root
export TF_VAR_cassandra_username=root
export TF_VAR_cassandra_password=rootpassword
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
vault write -force cassandra/rotate-root/cassandra
```

Dynamic role test:
```shell script
vault read cassandra/creds/readonly
```