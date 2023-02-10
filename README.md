# Bootstrap a multi-tenant TAP environment

## Pre-reqs
* Install the Azure CLI, and Terraform.
* [Sign in with the Azure CLI](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli) with the proper tenant, and user (or service principal) that has credentials to deploy AKS clusters.
* `export TMC_ENDPOINT=<your-tmc-tenant.tmc.cloud.vmware.com> VMW_CLOUD_API_TOKEN=<your-api-key>`

## Install
* `terraform init`
* `terraform apply`