
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vm_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vm_vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = var.address_space // here must add count
  location            = var.location
  resource_group_name = azurerm_resource_group.vm_rg.name
}

resource "azurerm_subnet" "vm_subnet" {
  name           = "${var.prefix}-subnet"
  address_prefixes = var.address_prefixes //here
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  resource_group_name  = azurerm_resource_group.vm_rg.name
}

resource "azurerm_network_security_group" "vm_security_group" {
  name                = "${var.prefix}-sg"
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name

}

resource "azurerm_network_security_rule" "vm_sec_rule" {
  name                        = "${var.prefix}-sg-rule"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.vm_rg.name
  network_security_group_name = azurerm_network_security_group.vm_security_group.name
}

resource "azurerm_subnet_network_security_group_association" "vm_sg_sub_association" {
  subnet_id                 = azurerm_subnet.vm_subnet.id
  network_security_group_id = azurerm_network_security_group.vm_security_group.id
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${var.prefix}-public-ip"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = azurerm_resource_group.vm_rg.location
  allocation_method   = var.allocation_method
 // ip_address          = var.ip_address
}




resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name

  ip_configuration {
    name                          = "${var.prefix}-ipconfig"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id = azurerm_public_ip.vm_public_ip.id
  }
}


resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}-vm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.vm_rg.name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.storage_account_type
  }

 os_profile {
    computer_name  = "${var.prefix}-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
      /*ssh_keys {
       path     = "/home/${var.admin_username}/.ssh/authorized_keys"
       key_data = var.ssh_public_key
    }*/
  }
}

