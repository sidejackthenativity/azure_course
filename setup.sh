#!/bin/bash

#Create a resource group
az group create -l eastus -n mirai-cloud-essentials

# Create an Azure Key Vault
# This vault is enabled for use during deployments and for disk encryption
# Soft delete or secrets and purge protection is also enabled
# PROVIDE YOUR OWN UNIQUE KEY VAULT NAME
az keyvault create \
    --resource-group mirai-cloud-essentials \
    --name key-vault-mirai \
    --enable-purge-protection true \
    --enable-soft-delete true \
    --enabled-for-deployment true \
    --enabled-for-disk-encryption true \
    --enabled-for-template-deployment true


# Create an Azure identity
az identity create \
    --resource-group mirai-cloud-essentials \
    --name identity-sql

# Create a SQL Server
# As it takes a few minutes to create the SQL server, return control to the CLI
# PROVIDE YOUR OWN SECURE --admin-password
az sql server create  \
    --resource-group mirai-cloud-essentials \
    --name sql-centralus \
    --admin-user miraiuser \
    --admin-password P@ssw0rdP@ssw0rd \
    --assign-identity \
    --no-wait

# Create a Cosmos DB instance
# As it takes a few minutes to create the Cosmos DB intance, return control to the CLI
az cosmosdb create \
    --resource-group mirai-cloud-essentials \
    --name cosmosdb-mirai \
    --kind mongodb \
    --enable-virtual-network true

# Create a Recovery Services vault for Backup and Site Recovery
az backup vault create \
    --resource-group mirai-cloud-essentials \
    --name recoveryvault-centralus \
    --location centralus
