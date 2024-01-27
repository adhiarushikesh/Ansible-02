# Create a resource group
resource "azurerm_resource_group" "RG01" {
  name     = "RG01"
  location = "Central India"
}

resource "azurerm_linux_virtual_machine" "RG01" {
  count                 = 4
  name                = "RG01-VM0${count.index}"
  resource_group_name = azurerm_resource_group.RG01.name
  location            = azurerm_resource_group.RG01.location

  size                = "Standard_B2s"
  admin_username      = "tadmin"
  network_interface_ids = ["${element(azurerm_network_interface.RG01.*.id, count.index)}"]
  
  
  admin_ssh_key {
    username   = "tadmin"
    public_key = file("./ssh/mykey.pub")
  }

  os_disk {
    name              = "RG01-VMDSK0${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_5-gen2"
    version   = "latest"
  }
}


output "resource_group_name" {
  value = azurerm_resource_group.RG01.name
}

