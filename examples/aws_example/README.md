# AWS secrets engine example

### Overview

In this example, the module will be used to enable and configure the AWS secrets engine.

### AWS requirements
Vault will require an aws account is required with programmatic access. This account should have the ability to create, list, delete AWS accounts. For this example, Vault will also require an IAM group to place provisioned accounts.  The permissions assigned to this group will depend on what actions the provisioned accounts need to perform.

For more information about AWS Groups and permissions, refer to the following resources:

- [AWS Groups best practices](https://aws.amazon.com/iam/features/manage-users/)
- [AWS Permissions best practices](https://aws.amazon.com/iam/features/manage-permissions/)

### Example use case
On occassions when engineers require programmatic access to AWS, an access key would normally be generated and securely distributed to them.  In these cases, these access keys are long-lived credentials, which, in the wrong hands, can cause a serious security incident. 

Using the Vault AWS secrets engine drastically reduces the attack surface, as engineers request a short-lived credential from Vault, which is automatically deleted when the TTL expires.

Should these generated credentials get into the wrong hands, malicious actors would have significantly less time to exploit them.

### Usage

Export the environment variables that contain the AWS Access Key ID and Secrets, replacing the redacted values for your environment:
```shell script
export TF_VAR_aws_access_key=redacted
export TF_VAR_aws_secret_key=redacted
```

Export the environment variable that contains the Vault token, again, replacing the value to reflect your environment:
```shell script
export TF_VAR_vault_token=root
```

Execute the following commands to run the example:
```shell script
terraform init
terraform plan -out=.tfplan
terraform apply .tfplan
```

To test that this secrets engine is working as intended, run the following commands as an authenticated Vault user:

```shell script
vault read aws/creds/test
```