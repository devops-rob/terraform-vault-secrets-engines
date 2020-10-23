# GCP Secrets Engine with OAuth2 example

### Overview
In this example, the module will be used to configure the GCP secrets engine with a role that dynamically provision OAuth2 tokens for GCP.

### Example use case

Configuring the GCP secrets engine to issue OAuth2 tokens is useful when building a platform that will be required to access Google Cloud resources.  For more information about OAuth2 and how to implement different workflows with it, refer to this [beginners guide.](https://medium.com/google-cloud/understanding-oauth2-and-building-a-basic-authorization-server-of-your-own-a-beginners-guide-cf7451a16f66) There are some [things to note](https://www.vaultproject.io/docs/secrets/gcp#things-to-note) when deciding with to use service accounts or OAuth tokens.

### GCP Requirements

- A GCP project.
- A GCP service account.
- The service account needs the following permissions:
    - iam.serviceAccountKeys.create
    - iam.serviceAccountKeys.delete
    - iam.serviceAccountKeys.get
    - iam.serviceAccountKeys.list
    - iam.serviceAccounts.create
    - iam.serviceAccounts.delete
    - iam.serviceAccounts.get
    - resourcemanager.projects.getIamPolicy
    - resourcemanager.projects.setIamPolicy
- A GCP credentials file for the service account.

For information about Service Accounts, Permissions and Roles, refer to the [Google Cloud documentation](https://cloud.google.com/iam/docs/creating-managing-service-accounts)

***NOTE: Credentials files should not be committed to Version Control systems.***

### Usage

Execute the following commands to run this example:
```shell script
terraform init
terraform plan -out=.tfplan
terraform apply .tfplan
```

To test the secrets engine is working as expected, run the following command as an authenticated Vault user:

```shell script
vault read gcp/token/oauth-role
```