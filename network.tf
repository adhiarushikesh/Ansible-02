resource "azurerm_network_watcher" "RG01" {
  name                = "RG01-NW01"
  location            = azurerm_resource_group.RG01.location
  resource_group_name = azurerm_resource_group.RG01.name
}


resource "azurerm_virtual_network" "RG01" {
  name                = "RG01-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RG01.location
  resource_group_name = azurerm_resource_group.RG01.name
}

resource "azurerm_subnet" "RG01" {
  name                 = "RG01-NET01"
  resource_group_name  = azurerm_resource_group.RG01.name
  virtual_network_name = azurerm_virtual_network.RG01.name
  address_prefixes     = ["10.0.2.0/24"]
}


resource "azurerm_network_interface" "RG01" {
  count = 4
  name                = "RG01-NIC0${count.index}"
  location            = azurerm_resource_group.RG01.location
  resource_group_name = azurerm_resource_group.RG01.name

  ip_configuration {
    name                          = "RG01-NCONF01"
    subnet_id                     = azurerm_subnet.RG01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.RG01[count.index].id
  }
}

resource "azurerm_network_security_group" "RG01" {
  name                = "RG01-NSG01"
  location            = azurerm_resource_group.RG01.location
  resource_group_name = azurerm_resource_group.RG01.name
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "PublicOut"
    priority                   = 1002
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "RG01" {
  subnet_id                 = azurerm_subnet.RG01.id
  network_security_group_id = azurerm_network_security_group.RG01.id
}

# Create Public IP Address
resource "azurerm_public_ip" "RG01" {
  count = 4
  name = "RG01-PIP0${count.index}"  
  resource_group_name = azurerm_resource_group.RG01.name
  location            = azurerm_resource_group.RG01.location
  allocation_method   = "Dynamic"
}
