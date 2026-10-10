data "azurerm_resource_group" "rg" {
  name = "state"
}

resource "azurerm_virtual_network" "network" {
  name = "rahman-network"
  address_space = ["10.0.0.0/16"]
  location = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name = "rahman-subnet"
  resource_group_name = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "interface" {
  name = "vm-nic"
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

data "azurerm_platform_image" "ubuntu" {
  location  = "eastus"
  publisher = "Canonical"
  offer     = "ubuntu-24_04-lts"
  sku       = "server"
}

resource "azurerm_linux_virtual_machine" "linux-vm" {
   name = "PlaygroundVM"
   resource_group_name = data.azurerm_resource_group.rg.name
   location = data.azurerm_resource_group.rg.location
   network_interface_ids = [azurerm_network_interface.interface.id]
   admin_username = "rahman"
   admin_password = "YourPassword123!"
   disable_password_authentication = false
   size = "Standard_D2ds_v5"
   os_disk {
     caching              = "ReadWrite"
     storage_account_type = "Standard_LRS"
   }
   source_image_reference {
    publisher =  data.azurerm_platform_image.ubuntu.publisher
    offer     = data.azurerm_platform_image.ubuntu.offer
    sku       = data.azurerm_platform_image.ubuntu.sku
    version   = data.azurerm_platform_image.ubuntu.version
  }
}