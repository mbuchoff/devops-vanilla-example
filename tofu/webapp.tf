resource "azurerm_service_plan" "main" {
  name                = "plan-${local.suffix}"
  location            = "eastus"
  os_type             = "Windows"
  resource_group_name = data.azurerm_resource_group.main.name
  sku_name            = "B1"
}

resource "azurerm_windows_web_app" "main" {
  location            = data.azurerm_resource_group.main.location
  name                = "app-${local.suffix}"
  resource_group_name = data.azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    always_on = false
  }

  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = terraform.workspace
    "KEYVAULT_URL"           = azurerm_key_vault.main.vault_uri
  }

  identity {
    type = "SystemAssigned"
  }
}
