variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
  default     = "4f6a6eb9-27d0-4ed6-a31c-2bde135e2db6"  # Your subscription ID
}

variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group"
  default     = "rg_sb_eastus_221777_1_172621721019"  # Your resource group name
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VM"
  default     = "Abcd@1234567"
}

variable "public_key_path" {
  type        = string
  description = "Path to the SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}
