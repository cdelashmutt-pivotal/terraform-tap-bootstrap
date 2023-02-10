resource "azurerm_resource_group" "default" {
  name     = "${var.project_name}-rg"
  location = "East US 2"
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.project_name}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${var.project_name}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 4
    vm_size         = "Standard_B2ms"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }
}
