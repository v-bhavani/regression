variable "resource_group_name" {
  description = "Existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Existing VNet name"
  type        = string
}

variable "subnet_name" {
  description = "Existing Subnet name"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "admin_password" {
  description = "Admin password"
  type        = string
  sensitive   = true
}

variable "os_disk_type" {
  description = "OS disk type"
  type        = string
}

variable "project" {
  type = string
}

variable "duration" {
  type = string
}

variable "owner" {
  type = string
}

variable "Holder" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "data_disks" {
  description = "Disks to create"
  type = map(object({
    disk_size = number
    disk_type = string
    disk_name = string
  }))
  default = {}
}

variable "attached_disks" {
  description = "Disks to attach (must exist in data_disks)"
  type = map(object({
    lun     = number
    caching = string
  }))
  default = {}
}
