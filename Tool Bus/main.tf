terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.52.0"
    }
  }
  backend "azurerm" {
    resource_group_name   = "rg-sc-core-vpt-cloudsvcs-01"
    storage_account_name  = "stncautomation01"
    container_name        = "toolbusapm"
    key                   = "toolbusapm.tfstate"
   }
}

provider "azurerm" {
  features {}
  subscription_id = "d6bec17e-0fa4-4822-ad5b-e4bbc20f9a16"
}

###Dev VMs####

resource "azurerm_network_interface" "nic-01-nc-p-vptprom01" {
  name                = "nic-01-nc-p-vptprom01"
  location            = "North Central US"
  resource_group_name = "rg-nc-core-vpt-prod-tools-apm-01"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/d6bec17e-0fa4-4822-ad5b-e4bbc20f9a16/resourceGroups/rg-nc-core-vpt-prod-sharedsvcs-01/providers/Microsoft.Network/virtualNetworks/vnet-nc-core-vpt-hub-01/subnets/snet-nc-core-vpt-prod-apm-01"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "nc-p-vptprom01" {
  name                            = "nc-p-vptprom01"
  resource_group_name             = "rg-nc-core-vpt-prod-tools-apm-01"
  location                        = "North Central US"
  size                            = "Standard_F16s_v2"
  admin_username                  = "vmadmin"
  admin_password                  = "Newday22!"
  disable_password_authentication = "false"
  network_interface_ids = [
    azurerm_network_interface.nic-01-nc-p-vptprom01.id,
  ]

  boot_diagnostics {
    storage_account_uri = "https://stprodcoreavdbootdiag002.blob.core.windows.net/"

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8_3"
    version   = "latest"
  }
}

resource "azurerm_managed_disk" "md-nc-p-vptprom01" {
  name                 = "md-nc-p-vptprom01"
  location             = "North Central US"
  resource_group_name  = "rg-nc-core-vpt-prod-tools-apm-01"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
}

resource "azurerm_virtual_machine_data_disk_attachment" "managed_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.md-nc-p-vptprom01.id
  virtual_machine_id = azurerm_linux_virtual_machine.nc-p-vptprom01.id
  lun                = "1"
  caching            = "ReadWrite"
}

#VMprom01

resource "azurerm_network_interface" "nic-01-nc-p-vptprom02" {
  name                = "nic-01-nc-p-vptprom02"
  location            = "North Central US"
  resource_group_name = "rg-nc-core-vpt-prod-tools-apm-01"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/d6bec17e-0fa4-4822-ad5b-e4bbc20f9a16/resourceGroups/rg-nc-core-vpt-prod-sharedsvcs-01/providers/Microsoft.Network/virtualNetworks/vnet-nc-core-vpt-hub-01/subnets/snet-nc-core-vpt-prod-apm-01"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "nc-p-vptprom02" {
  name                            = "nc-p-vptprom02"
  resource_group_name             = "rg-nc-core-vpt-prod-tools-apm-01"
  location                        = "North Central US"
  size                            = "Standard_F16s_v2"
  admin_username                  = "vmadmin"
  admin_password                  = "Newday22!"
  disable_password_authentication = "false"
  network_interface_ids = [
    azurerm_network_interface.nic-01-nc-p-vptprom02.id,
  ]

  boot_diagnostics {
    storage_account_uri = "https://stprodcoreavdbootdiag002.blob.core.windows.net/"

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8_3"
    version   = "latest"
  }
}

resource "azurerm_managed_disk" "md-nc-p-vptprom02" {
  name                 = "md-nc-p-vptprom02"
  location             = "North Central US"
  resource_group_name  = "rg-nc-core-vpt-prod-tools-apm-01"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
}

resource "azurerm_virtual_machine_data_disk_attachment" "managed_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.md-nc-p-vptprom02.id
  virtual_machine_id = azurerm_linux_virtual_machine.nc-p-vptprom02.id
  lun                = "1"
  caching            = "ReadWrite"
}


#vmtlxdev01

resource "azurerm_network_interface" "nic-01-nc-p-vptlxdev01" {
  name                = "nic-01-nc-p-vptlxdev01"
  location            = "North Central US"
  resource_group_name = "rg-nc-core-vpt-prod-tools-apm-01"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/d6bec17e-0fa4-4822-ad5b-e4bbc20f9a16/resourceGroups/rg-nc-core-vpt-prod-sharedsvcs-01/providers/Microsoft.Network/virtualNetworks/vnet-nc-core-vpt-hub-01/subnets/snet-nc-core-vpt-prod-apm-01"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "nc-p-vptlxdev01" {
  name                            = "nc-p-vptlxdev01"
  resource_group_name             = "rg-nc-core-vpt-prod-tools-apm-01"
  location                        = "North Central US"
  size                            = "Standard_F4s_v2"
  admin_username                  = "vmadmin"
  admin_password                  = "Newday22!"
  disable_password_authentication = "false"
  network_interface_ids = [
    azurerm_network_interface.nic-01-nc-p-vptlxdev01.id,
  ]

  boot_diagnostics {
    storage_account_uri = "https://stprodcoreavdbootdiag002.blob.core.windows.net/"

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8_3"
    version   = "latest"
  }
}

resource "azurerm_managed_disk" "md-nc-p-vptlxdev01" {
  name                 = "md-nc-p-vptlxdev01"
  location             = "North Central US"
  resource_group_name  = "rg-nc-core-vpt-prod-tools-apm-01"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
}

resource "azurerm_virtual_machine_data_disk_attachment" "managed_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.md-nc-p-vptlxdev01.id
  virtual_machine_id = azurerm_linux_virtual_machine.nc-p-vptlxdev01.id
  lun                = "1"
  caching            = "ReadWrite"
}