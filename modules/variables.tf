variable "prefix" {
  default = ""
}
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for the VM"
}

variable "location" {
  type        = string
  description = "Azure region for the VM"
}

variable "vm_name" {
  type        = string
  description = "Name of the VM"
}

variable "vm_size" {
  type        = string
  description = "Size of the VM"
}

variable "admin_username" {
  type        = string
  description = "Username for the VM admin account"
}

variable "admin_password" {
  type        = string
  description = "Password for the VM admin account"
}
variable "address_space" {
  type        = list(any)
  default     = ["10.13.0.0/16"]
  description = "Address space for the virtual network"
}
variable "address_prefixes" {
  type        = list(any)
  default     = ["10.0.0.0/16"]
  description = "Address space for the virtual network"
}
variable "private_ip_address_allocation" {
  description = "Defines how an IP address is assigned. Options are Static or Dynamic."
  default     = "dynamic"
}
variable "storage_account_type" {
  description = "Defines the type of storage account to be created. Valid options are Standard_LRS, Standard_ZRS, Standard_GRS, Standard_RAGRS, Premium_LRS."
}
variable "ssh_public_key" {
  description = "Path to the public key to be used for ssh access to the VM.  Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub"
  default     = "~/.ssh/id_rsa.pub"
}
variable "allocation_method" {
  description = "allocation method : dynamic, static"
}