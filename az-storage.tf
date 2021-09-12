resource "azurerm_storage_account" "storage_afa" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  name                     = "stor${replace(var.project, "-", "")}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
