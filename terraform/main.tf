terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.66.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.0"
    }
    tanzu-mission-control = {
      source = "vmware/tanzu-mission-control"
      version = ">= 1.1.5"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }

  required_version = ">= 0.14"
}

provider "kubernetes" {
  config_path = local_file.kubeconfig.filename
  # host                   = azurerm_kubernetes_cluster.default.kube_config.0.host
  # client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  # client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  # cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
}

provider "kubectl" {
  config_path = local_file.kubeconfig.filename
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {
}

data "azuread_client_config" "current" {
}