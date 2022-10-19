##### Begin Resource Grp #####
resource "azurerm_resource_group" "rg-primaryasr-01" {
  name     = "rg-sc-sub1-vpt-test-primaryasr-01"
  location = "South Central US"
}
##### End Resource Grp #####

##### Networking Start #####
resource "azurerm_network_security_group" "nsg-primaryasr-01" {
  name                = "nsg-snet-sc-sub1-vpt-test-primaryasr-01"
  resource_group_name = azurerm_resource_group.rg-primaryasr-01.name
  location            = azurerm_resource_group.rg-primaryasr-01.location
}

resource "azurerm_virtual_network" "vnet-primaryasr-01" {
  name                = "vnet-sc-sub1-vpt-test-primaryasr-01"
  address_space       = ["10.90.0.0/16"]
  resource_group_name = azurerm_resource_group.rg-primaryasr-01.name
  location            = azurerm_resource_group.rg-primaryasr-01.location
}

#resource "azurerm_subnet" "snet-asr-01" {
#  name                 = "snet-sc-sub1-vpt-test-asr-01"
#  virtual_network_name = azurerm_virtual_network.vnet-primaryasr-01.name
#  resource_group_name  = "rg-sc-sub1-vpt-test-primaryasr-01"
#  address_prefixes     = ["10.90.1.0/24"]
#  enforce_private_link_endpoint_network_policies = true
#  service_endpoints    = ["Microsoft.Storage"]
#}

#resource "azurerm_subnet" "snet-asr-02" {
#  name                 = "snet-sc-sub1-vpt-test-asr-02"
#  virtual_network_name = azurerm_virtual_network.vnet-primaryasr-01.name
#  resource_group_name  = "rg-sc-sub1-vpt-test-primaryasr-01"
#  address_prefixes     = ["10.90.2.0/24"]
#  enforce_private_link_endpoint_network_policies = true
#  service_endpoints    = ["Microsoft.Storage"]
#}

##### Networking End #####
#
# resource "azurerm_public_ip" "pip-asr-01" {
#   name                   = "pip-sc-sub1-vpt-test-asr-01"
#   location               = "South Central US"
#   resource_group_name    = "rg-sc-sub1-vpt-test-asr-01"
#   allocation_method      = "Static"
# }
#
# resource "azurerm_lb" "lb-asr-01" {
#   name                = "lb-sc-sub1-vpt-test-asr-01"
#   location            = "South Central US"
#   resource_group_name = "rg-sc-sub1-vpt-test-asr-01"
#
#   frontend_ip_configuration {
#     name                 = "publicIPAddress"
#     public_ip_address_id = azurerm_public_ip.pip-asr-01.id
#   }
# }
#
# resource "azurerm_lb_backend_address_pool" "bap-asr-01" {
#   loadbalancer_id     = azurerm_lb.lb-asr-01.id
#   name                = "BackEndAddressPool"
# }
#
# resource "azurerm_network_interface" "nic-asr" {
#   count               = 2
#   name                = "nic-sc-vptasrweb0${count.index}"
#   location            = "South Central US"
#   resource_group_name = "rg-sc-sub1-vpt-test-asr-01"
#
#   ip_configuration {
#     name                          = "ipcfg-sc-sub1-vpt-test-asr-01"
#     subnet_id                     = azurerm_subnet.snet-asr-01.id
#     private_ip_address_allocation = "dynamic"
#   }
# }
#
# resource "azurerm_windows_virtual_machine" "vm-sc-vptweb0" {
#   count                 = 2
#   name                  = "vm-sc-vptweb0${count.index}"
#   location              = "South Central US"
#   availability_set_id   = "/subscriptions/aeba7e2f-bbfc-43d1-b64c-5018f7dfedd8/resourceGroups/rg-sc-sub1-vpt-test-asr-01/providers/Microsoft.Compute/availabilitySets/as-sc-sub1-vpt-test-asr-01"
#   resource_group_name   = "rg-sc-sub1-vpt-test-asr-01"
#   network_interface_ids =  [element(azurerm_network_interface.nic-asr.*.id, count.index)]
#   size                  = "Standard_D2as_v4"
#   admin_username        = "vmadmin"
#   admin_password        = "Newday22!"
#
#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2019-Datacenter"
#     version   = "latest"
#   }
#
#   os_disk {
#     name                 = "osdisk_vm-sc-vptasrweb0${count.index}"
#     caching              = "ReadWrite"
#     storage_account_type = "Premium_LRS"
#   }
# }
#