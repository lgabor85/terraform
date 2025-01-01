# Understand the generated Terraform files

CodeToCloud generates Terraform code to create the Azure resources according to your infrastructure requirements and manages the connection between created Azure services. The generator takes care of app settings, authentication settings (identity enabling and role assignments), and public network settings to make your service work once deployed.

## Terraform files

Iac Generator for Terraform generates `main.tf` to create the compute resources, `variables.tf` to take user input, and other Terraform files with the resource type name to create each resource.

1. `main.tf`
    This file first creates a new resource group. Compute resources such as Linux App Service, Container Apps, and Azure Functions are also created in `main.tf`. The dependency resources such as App Service Plan and Container Apps Environment are created in separate files. One kind of compute resource shares a single dependency resource. App settings and environment variables are configured based on each target resource. Implicit dependencies are used to get the necessary keys, connection strings, and principal IDs of system identity from the Terraform files of the resources.

1. Terraform files for resources

    For each kind of resource except the compute resources, a Terraform file with the name of the resource type creates all the instances of the service. Required parameters for resource creation are configured with some default values.

    - `role.tf` creates the role assignments to grant necessary access to system identity of compute resources if identity-based connection is used.

1. `variables.tf`

    This file contains the parameters that require user input. Replace the '<...>' placeholder with your values according to the hints provided by the variable names.

    - Modify the suffix of resource group name by changing 'resource_suffix'.
    - Customize the location.
## Next Step

1. Complete the input parameters.
1. Customize the configurations of the resources.
1. Provision the resources. You can refer to [Terraform Tutorials](https://developer.hashicorp.com/terraform/tutorials/cli).
