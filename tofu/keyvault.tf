resource "azurerm_key_vault" "main" {
  name                = "kv-devvanex-${terraform.workspace}-${local.last4SubscriptionId}"
  resource_group_name = data.azurerm_resource_group.main.name
  sku_name            = "standard"
  location            = data.azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

}

resource "azurerm_key_vault_access_policy" "self" {
  key_vault_id       = azurerm_key_vault.main.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id
  secret_permissions = ["Set", "Get", "List", "Delete"]
}

resource "azurerm_key_vault_access_policy" "webapp" {
  key_vault_id       = azurerm_key_vault.main.id
  object_id          = azurerm_windows_web_app.main.identity.0.principal_id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_secret" "main" {
  name         = "sqlconnectionstring"
  key_vault_id = azurerm_key_vault.main.id
  value        = "Server=tcp:${azurerm_mssql_server.main.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.main.name};Persist Security Info=False;User ID=${local.mssql_user};Password=${random_password.password.result};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}
