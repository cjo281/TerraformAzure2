terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateccount"
    container_name       = "staging"
    key                  = "staging.terraform.tfstate"
    

  }
}