# RabbitMQ Secrets Engine Vhost read-only example

### Overview

In this example, the module will be used to enable and configure the RabbitMQ secrets engine for read-only permissions on a vhost

### Example use case

For cases where, engineers or applications require read-only access to resources in a specific virtual host. For more information about Virtual Hosts, refer to the [Logical and Physical Separation documentation.](https://www.rabbitmq.com/vhosts.html#logical-separation)

### RabbitMQ Requirements

Vault will require a RabbitMQ user with the Administrator management plugin tag.  No other permissions are required. This gives read permissions to all resources within this virtual host.

For more information about RabbitMQ Access and Permissions, refer to the [rabbitmqctl documentation.](https://www.rabbitmq.com/management.html#permissions)

### Usage

The first step is to export the environment variables that contain the Vault token and RabbitMQ credentials.  Execute the following commands, replacing the variable values to match your environment:

```shell script
export TF_VAR_vault_token=root
export TF_VAR_rabbitmq_username=guest
export TF_VAR_rabbitmq_password=guest
```

Execute the following commands to run the example:

```shell script
terraform init
terraform plan -out=.tfplan
terraform apply .tfplan
```

To test the secrets engine is working as expected, run the following command as an authenticated Vault user:

```shell script
vault read rabbitmq/creds/test
```