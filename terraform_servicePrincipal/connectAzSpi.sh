#!/bin/bash

# Initialize Terraform if not done already
terraform init

# Apply your Terraform configuration if not done already (remove -auto-approve if you're running in an interactive environment)
terraform apply -auto-approve

# Retrieve the Terraform outputs as JSON 
outputs=$(terraform output --json)

# Parse the JSON to get the required fields using jq
service_principal_app_id=$(echo $outputs | jq -r '.service_principal_app_id.value')
service_principal_password=$(echo $outputs | jq -r '.service_principal_password.value')
subscription_id=$(echo $outputs | jq -r '.subscription_id.value')

# Output the retrieved values
echo "Service Principal App ID: $service_principal_app_id"
echo "Service Principal Password: $service_principal_password"
echo "Subscription ID: $subscription_id"

# Authenticate to Azure using the Service Principal
az login --service-principal --username "$service_principal_app_id" --password "$service_principal_password" --tenant YOUR_TENANT_ID

# Verify the authentication
az account show