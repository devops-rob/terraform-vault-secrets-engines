# MySQL with dynamic and static roles Example

### Overview

In this example, the module will be used to enable and configure the database secrets engine for MySQL.  The configuration will include dynamic and static roles for MySQL.

### MySQL requirements

Vault will require a highly privileged user with root level permissions. Once this user credential was rotated, only the Vault knows the new password. For this reason, it is recommended practice to create a user specifically for Vault.
### Example use case

Databases often store business critical data, which, if in the wrong hands, could cause real damage to an organisation, both financial and reputational. The risk of data exposure is increased when credentials that provide access to the data is long-lived.

Using Vault, ephemeral credentials can instead be provided to operators and applications.  This reduces the attack surface as credentials, if exposed, have a short TTL and lessens the probability of an accidental or malicious data breach. When the TTL of a credential expires, the credential is revoked. This can be achieved by creating a Vault role.

In order for Vault to perform this function, Vault itself will require a highly privileged long-lived user for the database.  This once again increases the attack surface. To mitigate against that risk, Vault has a Static role, whereby Vault can rotate this long-lived credential and only Vault will know what it is. This allows you to rotate the credential in accordance with your organisation's security policy.
### Usage

Export the environment variables that contain the Vault token, and the MySQL connection details. Execute the following commands, replacing the variable values to match your environment:
```shell script
export TF_VAR_mysql_user=root
export TF_VAR_mysql_password=root
``` 

Execute the following commands to run the example:
```shell script
terraform init
terraform plan -out=.tfplan
terraform apply .tfplan
```