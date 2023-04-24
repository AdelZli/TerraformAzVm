
prefix                        = "staging-"
resource_group_name           = "my-resource-group"
location                      = "eastus"
vm_name                       = "my-vm"
vm_size                       = "Standard_D2_v2"
admin_username                = "azuredev"
admin_password                = "MyP@ssw0rd"
address_space                 = ["10.0.0.0/16"]
address_prefixes              = ["10.0.1.0/24"]
private_ip_address_allocation = "Dynamic"
storage_account_type          = "Standard_LRS"
//ssh_public_key                = "mykey.pub"
allocation_method = "Static"
