resource "random_id" "server" {
  byte_length = 8
}

resource "azurerm_storage_account" "tap" {
  name                     = "tap${random_id.server.hex}"
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "techdocs" {
  name                  = "techdocs"
  storage_account_name  = azurerm_storage_account.tap.name
  container_access_type = "private"
}