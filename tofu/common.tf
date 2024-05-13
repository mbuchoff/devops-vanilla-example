terraform {
  backend "azurerm" {
    container_name = "terraform"
    key            = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

locals {
  last4SubscriptionId = substr(data.azurerm_subscription.azure_subscription.subscription_id, length(data.azurerm_subscription.azure_subscription.subscription_id) - 4, 4)
  name                = "devopsvanillaexample"
  suffix              = "${local.name}-${terraform.workspace}-${local.last4SubscriptionId}"
  mssql_user          = "sqladmin"
}

data "azurerm_resource_group" "main" {
  name = "rg-${local.name}-${local.last4SubscriptionId}"
}

data "azurerm_subscription" "azure_subscription" {
}
