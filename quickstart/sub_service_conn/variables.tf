# general variables
variable "site_name" {
  type        = string
  description = "Site name"
}

variable "site_stage_code" {
  type        = string
  description = "Site stage code (TST, ACC or PRD)"
}

# azuredevops secrets
variable "personal_access_token" {
  type        = string
  sensitive   = true
  description = "Access token for our Azure Devops environment, token has to be both admin on Azure Devops ánd owner on the Azure environment: this is why the token needs to be created under our tenant admin accounts"
}

# subscription secrets
variable "mca_billing_account_name" {
  type        = string
  sensitive   = true
  description = "Billing account name"
}

variable "mca_billing_profile_name" {
  type        = string
  sensitive   = true
  description = "Billing profile name"
}

variable "mca_invoice_section_name" {
  type        = string
  sensitive   = true
  description = "Invoice section name"
}

# subscription variables
variable "workload" {
  type        = string
  description = "Optional) The workload type of the Subscription. Possible values are Production (default) and DevTest. Changing this forces a new Subscription to be created."
}

# role assignment variables
variable "hub_vnet_role_assignment_scope" {
  type        = string
  description = "Resource ID of the VNET at the hub site the new site peers to"
}
