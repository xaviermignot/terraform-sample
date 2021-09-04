resource "azurerm_app_service_plan" "plan" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  name = "plan-afa-${var.project}"
  kind = "functionapp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "afa" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  name                       = "afa-${var.project}"
  app_service_plan_id        = azurerm_app_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.storage_afa.name
  storage_account_access_key = azurerm_storage_account.storage_afa.primary_access_key

  version    = "~3"
  https_only = true

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.ai.instrumentation_key
  }
}
