# Multi-Cluster TAP Template
This project attempts to capture a pattern for deploying TAP in a multi-cluster environment with a central cluster to consolidate all clusters and APIs into a single view, as well as separate Iterate and Run clusters for organizational units.  

This template is currently targeted at Azure for the backing IaaS.

## Pre-reqs
* This repository is intended to be a template to bootstrap from.  Make a copy of it, fork it, or download the ZIP archive and create your own new repository to get started.
* Install the Azure CLI, and Terraform.
* [Sign in with the Azure CLI](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli) with the proper tenant, and user (or service principal) that has administrative priviledges to your Azure acccount.  This account will be used to bootstrap the environment from your local machine, but then will use reduce priviledges on an ongoing basis.
* Create a DNS zone that can be used for hostnames associated with the environment.
* `export TMC_ENDPOINT=<your-tmc-tenant.tmc.cloud.vmware.com> VMW_CLOUD_API_TOKEN=<your-api-key>`
* Enable Azure AKS Preview extension
  * `az extension add --name aks-preview && az extension update --name aks-preview`

## Install
* `cd terraform`
* `terraform init`
* `terraform apply`