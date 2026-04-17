terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "apptfstate"
    container_name       = "tfstate"
    key                  = "app.tfstate"
  }
}
