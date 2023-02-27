output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}

output "az_cluster_creds_command" {
  description = "The `az` cli command to get the admin credentials for the AKS cluster"
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.default.name} --name ${azurerm_kubernetes_cluster.default.name} --admin"
}

output "publish_techdocs" {
  description = "Command to publish techdocs"
  value = "npx @techdocs/cli publish --publisher-type azureBlobStorage --storage-name ${azurerm_storage_container.techdocs.name} --entity default/component/tap-gui-component --directory /tmp/tap-gui --azureAccountName ${azurerm_storage_account.tap.name} --azureAccountKey ${azurerm_storage_account.tap.primary_access_key}"
  sensitive = true
}

output "storage_account" {
  value = azurerm_storage_account.tap.name
}

output "storage_account_container" {
  value = azurerm_storage_container.techdocs.name
}

output "storage_account_key" {
  value = azurerm_storage_account.tap.primary_access_key
  sensitive = true
}

# output "host" {
#   value = azurerm_kubernetes_cluster.default.kube_config.0.host
# }

# output "client_key" {
#   value = azurerm_kubernetes_cluster.default.kube_config.0.client_key
# }

# output "client_certificate" {
#   value = azurerm_kubernetes_cluster.default.kube_config.0.client_certificate
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.default.kube_config_raw
# }

# output "cluster_username" {
#   value = azurerm_kubernetes_cluster.default.kube_config.0.username
# }

# output "cluster_password" {
#   value = azurerm_kubernetes_cluster.default.kube_config.0.password
# }
