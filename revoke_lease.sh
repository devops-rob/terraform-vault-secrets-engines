#!/usr/bin/env bash

# This script will revoke all leases with the mount/creds prefix
#
# This is required due to the way Vault revokes
# This module creates and manages 4 resources in this order:
# 1 - Vault mount
# 2 - Database connection config Which relies on a mount being in place
# 3 - Vault dynamic role which relies on both the mount and connection being in place to work.
# 4 - Vault static role which relies on both the mount and connection being in place to work.
#
# When terraform destroys these resources, it does so in the reverse order.
# The Vault mount is responsible for revoking all leases when being destroyed.
# For this to happen, the Mount relies on the connection config to be in place
# This is so that Vault can connect to the database and clean up the accounts it has provisioned.
# This prevents secrets sprawl but causes the destroy command to fail if there are leases.
# Running this script as a local-exec destroy provisioner on all the database connection config resources in the module
# prevents the destroy command from failing as all leases are revoked by the time the mount is being destroyed.
#
# The script requires:
# 1 - Vault address
# 2 - Vault token
# 3 - Vault mount path
#
# Log in to Vault
vault login -address="${3}" "$1" > /dev/null

# List leases on the mount path and loop over the list with the revoke command until list is empty
while [[ $(vault list -address="${3}" -format "json" sys/leases/lookup/"${2}"/creds) != "{}" ]]
do
    vault lease revoke -address="${3}" -prefix "${2}"/creds
done
