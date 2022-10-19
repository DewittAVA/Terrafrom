terraform {
  backend "azurerm" {
    resource_group_name   = "rg-DevOps-Test-02"
    storage_account_name  = "devopsautomation01142022"
    container_name        = "test-terraform-state"
    key                   = "devopstest.tfstate"
  }
}