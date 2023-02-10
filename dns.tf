# Query the current master zone
data "azurerm_dns_zone" "dns" {
  #TODO: Hardcoded
  name = "azure.grogscave.net"
}

data "azurerm_resource_group" "dns" {
  #TODO: Hardcoded
  name = "dns"
}

resource "azuread_application" "external_dns" {
  display_name = "${var.project_name}-external-dns"
  owners = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "external_dns" {
  application_object_id = azuread_application.external_dns.object_id
}

resource "azuread_service_principal" "external_dns" {
  application_id = azuread_application.external_dns.application_id
  owners = [data.azuread_client_config.current.object_id]
}

resource "azurerm_role_assignment" "resource_group_reader" {
  scope                = data.azurerm_resource_group.dns.id
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.external_dns.id
}

resource "azurerm_role_assignment" "dns_contributer" {
  scope                = data.azurerm_dns_zone.dns.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azuread_service_principal.external_dns.id
}