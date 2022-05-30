resource "azurerm_service_plan" "plan" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  name     = "plan-afa-${var.project}"
  os_type  = "Linux"
  sku_name = "Y1"
}

resource "azurerm_linux_function_app" "afa" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  name                       = "afa-${var.project}"
  service_plan_id        = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.storage_afa.name
  storage_account_access_key = azurerm_storage_account.storage_afa.primary_access_key

  https_only = true

  site_config {
    application_insights_key = azurerm_application_insights.ai.instrumentation_key
  }
}
