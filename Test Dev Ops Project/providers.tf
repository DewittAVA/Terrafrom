provider "azurerm" {
  features {}
  subscription_id   = "aeba7e2f-bbfc-43d1-b64c-5018f7dfedd8"
  client_id         = var.spn-client-id
  client_secret     = var.spn-client-secret
  tenant_id         = var.spn-tenant-id 
}