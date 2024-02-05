data "azurerm_service_plan" "main" {
  name                = "plan-${local.name}"
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_windows_web_app" "main" {
  location            = data.azurerm_resource_group.main.location
  name                = "app-${local.suffix}"
  resource_group_name = data.azurerm_resource_group.main.name
  service_plan_id     = data.azurerm_service_plan.main.id

  site_config {
    always_on = false
  }

  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = terraform.workspace
  }

  identity {
    type = "SystemAssigned"
  }
}
