resource "azurerm_application_insights" "ai" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  name             = "ai-${var.project}"
  application_type = "web"
}
