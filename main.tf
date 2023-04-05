

# Defining the module configuration
module "azure_vm" {
  source = "./modules"

  prefix                        = var.prefix
  resource_group_name           = var.resource_group_name
  location                      = var.location
  vm_name                       = var.vm_name
  vm_size                       = var.vm_size
  admin_username                = var.admin_username
  admin_password                = var.admin_password
  address_space                 = var.address_space
  address_prefixes              = var.address_prefixes
  private_ip_address_allocation = var.private_ip_address_allocation
  storage_account_type          = var.storage_account_type
  ssh_public_key                = var.ssh_public_key
  allocation_method             = var.allocation_method
}

# Define an output to retrieve the public IP address of the VM
output "public_ip_address" {
  value = module.azure_vm.public_ip_address
}

output "private_ip_address" {
  value = module.azure_vm.private_ip_address
}
