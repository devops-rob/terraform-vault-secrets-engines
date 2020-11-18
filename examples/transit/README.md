# Transit example

### Overview

In this example, the module will be used to enable and configure the transit secrets engine with two RSA-2048 encryption keys.

### Example use case

Modern applications often have to handle sensitive data.  This could be anything from credit card number to National Insurance numbers. As application developers, there is a duty of care to protect this data when at rest and whilst in transit.

One way to protect this data, is to encrypt it before it is sent to its storage location. Cryptography can be very complicated to implement in applications.  Mistakes in the implementation can be very costly for a business.

Application developers can now leverage Vault to delegate encryption away from their apps and instead, rely on Vault to perform the cryptography function.  Vault will manage the keys securely and rich access controls can be implemented by leveraging Vault policies.

In this scenario, there is an application which is hosted on a development and staging environment.  It has been decided that each environment should have its own cryptographic key. In this case, two keys are created to match their respective environment names.
### Usage

Export the environment variable that contain the Vault token.  Execute the following command, replacing the variable value to match your environment:

```shell script
export TF_VAR_vault_token=root
```

Execute the following commands to run the example:

```shell script
terraform init
terraform plan -out=.tfplan
terraform apply .tfplan
```

To test these keys are working correctly, encrypt and decrypt some data using the keys created.  Run the following commands as an authenticated Vault user, making a note of the output of each command, to encrypt the data.  The output will be required for the next step.

For "dev", run:
```shell script
vault write transit/encrypt/dev plaintext=$(base64 <<< "my secret data")
```

For "staging", run:
```shell script
vault write transit/encrypt/staging plaintext=$(base64 <<< "my secret data")
```

The next step is to decrypt the ciphertext into plain text.  Run the following commands for each environment, replacing the ciphertext with the output from the encryption step.  Make a not of the plaintext output as this will be base64 encoded, so will need to be decoded in the next step

For "dev", run:
```shell script
vault write transit/decrypt/dev \
  ciphertext=vault:v1:LdAI8FXZZV6O09Htc5GQgv9yFl/l2mKt0wgEYGvoCwyGoE6CXJOMUXzPy0p7rYBMK8HjNbe7Ba4smHUw0jVLvY3sgf7ixkOoATPzjwtS4DhOCNhNqUPn022BvppyO6hWqS5eFhiipD5L3nE4fo4842x5IwATGbeKtyTkH6alJfnYE/+SZtDimumy4Mql59VAUu//EhuoDKuxjw0NcuKWA1TfbTW9OI3gHfvsAHm8aNkxEi+M4lXssv/uGMUl0mI+gcZkD8VG+1HmDDtScnVWNiG1Vmz/eMfG4xq6QfyGZFeQWYf96CHutWeXZcswk0PmBjQJq+BIbXny3U25esucqA==
```

For "staging", run:
```shell script
vault write transit/decrypt/staging \
    ciphertext=vault:v1:k5/EG1AlISUfI6+h+GBuKbvGVTfLJncAcRIVduyU0ArJOvABOm75uDAZjPFPJGMMwOPIlbLUQXUdMae6f+67IrEfiLsN8RZPOklQyw5zNNcTVDx17IHR6EHNY5ib8yVhJ+44GHvENxFXb3UH+xjfC7dJz8QWI/KkBSQoyyGqI3ouQQyCtkePHfnE373sG0hr7E42seuUHG2e6lCdjlY3+Qtpu2EU/YnYvaC1Ljmkym9ndvEpfrQ46jRBWu9cU1I8tl/uRrAXwRi1bJe8rzmBQwd2LdoXJO8wlooXpMNfBf086w8KPLxXBcyBURYOAZIOq+JZA8Xohf6SSc3oW/+EJA==
```
Both of these commands should return the same plaintext value as they are both base64 encoded.

The final step is to decode the plaintext using base64.  Run the follow command , replacing the plaintext with the command output from the previous commands:

```shell script
echo bXkgc2VjcmV0IGRhdGEK | base64 --decode
```