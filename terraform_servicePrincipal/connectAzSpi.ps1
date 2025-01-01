# Run Terraform and capture the outputs in JSON format
$terraformOutputs = terraform output -json | ConvertFrom-Json

# Extract required outputs
$servicePrincipalAppId = $terraformOutputs.service_principal_app_id.value
$servicePrincipalPassword = $terraformOutputs.service_principal_password.value
$subscriptionId = $terraformOutputs.subscription_id.value

# Optional: Display the extracted values (remove in production)
Write-Output "Service Principal App ID: $servicePrincipalAppId"
Write-Output "Service Principal Password: $servicePrincipalPassword"
Write-Output "Subscription ID: $subscriptionId"

# Define your Tenant ID (You need to locate this if not provided)
$tenantId = "your-tenant-id"  # Replace with your actual tenant ID

# Create a secure string for the password
$secPassword = ConvertTo-SecureString $servicePrincipalPassword -AsPlainText -Force

# Create a PSCredential object
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $servicePrincipalAppId, $secPassword

# Connect to Azure
Connect-AzAccount -ServicePrincipal -ApplicationId $servicePrincipalAppId -TenantId $tenantId -Credential $credential

# Verify connection
Get-AzSubscription