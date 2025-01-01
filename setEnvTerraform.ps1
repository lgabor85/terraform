# This script is used to set the environment variables for Terraform

Write-Host "Setting environment variables for Terraform"

$Env:ARM_CLIENT_ID = "816fded0-4ab1-47f0-890e-4f8f85eeb0d8"
$Env:ARM_CLIENT_SECRET = "JRf8Q~XhviGyOImG.pQghz2HrYNaTb.AO56x-bHy"
$Env:ARM_SUBSCRIPTION_ID = "21746260-d74d-4799-b99f-0c4cf7080e7d"
$Env:ARM_TENANT_ID = "7f30eb9a-410e-4268-94b4-56339adeddc8"

Write-Host "Environment variables set for Terraform"
Write-Host "ARM_CLIENT_ID: $Env:ARM_CLIENT_ID"
Write-Host "ARM_CLIENT_SECRET: $Env:ARM_CLIENT_SECRET"
Write-Host "ARM_SUBSCRIPTION_ID: $Env:ARM_SUBSCRIPTION_ID"
Write-Host "ARM_TENANT_ID: $Env:ARM_TENANT_ID"