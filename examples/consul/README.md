# Consul example

### Overview

In this example, the module will be used to enable and configure the Consul secrets engine with two policies.

### Example use case

There are instances where an application may need to read or update consul components, for example, key/value data in the KV store, in an ACL enabled consul cluster. In these scenarios, developers will need to provide the application with a consul acl token.

In order to reduce the attack surface of the application, developers can leverage Vault to dynamically provision Consul ACL tokens  when an application requires access, and clean the token up when its TTL expires. 

This module can be used to enable and configure the Consul secrets engine for developers to leverage as discussed above.

### Consul Requirements

Vault will require a Consul ACL token to authenticate with Consul.  To enable the ACL system in Consul, ensure the ACL stanza is declared in the Consul configuration.  

The below is an example of the ACL stanza:

```json
"acl": {
      "enabled": true,
      "default_policy": "deny",
      "enable_token_persistence": true
}
```

It's best practice to create a token specifically for Vault to use. The token will need write permissions on the ACL capability.  The following policy will be sufficient for Vault to work with Consul:

```hcl
acl = "write"
```

This policy gives Vault the permissions to create, update and delete Consul ACL tokens.  It will not allow any actions outside of managing the Consul ACL system.

You will also require the two Consul policies that are referenced in this example, which are 
- test-policy
- test-policy-2

These policies can contain any rules that you wish to use.  For more information on ACL policies, refer to the [Consul ACL documentaion.](https://www.consul.io/docs/security/acl/acl-rules)

### Usage

Export the environment variables that contain the Vault token and Consul ACL token.  Execute the following commands, replacing the variable values to match your environment:

```shell script
export TF_VAR_vault_token=root
export TF_VAR_consul_token=cf09fb0f-f54e-c7c1-0541-51d82f5fa219
```

Execute the following commands to run the example:

```shell script
terraform init
terraform plan -out=.tfplan
terraform apply .tfplan
```

To test the secrets engine is working as expected, run the following command as an authenticated Vault user:

```shell script
vault read consul/creds/test
```