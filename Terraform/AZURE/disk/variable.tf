variable "resourcegroup" {
  description = "The name of the Azure resource group"
  type        = string
  default     = "cloud-demo"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "diskname" {
  description = "Name of the managed disk"
  type        = string
  default     = "testdisktf2"
}

variable "st_acc_type" {
  description = "The storage account type (e.g., Standard_LRS, Premium_LRS)"
  type        = string
  default     = "Standard_LRS"
}

variable "disktype" {
  description = "Size of the managed disk in GB"
  type        = number
  default     = 4
}

variable "project" {
  description = "Project name associated with the disk"
  type        = string
  default     = "Terraform test"
}

variable "duration" {
  description = "Expected usage duration or lifecycle of the disk"
  type        = string
  default     = "required duration"
}

variable "owner" {
  description = "Owner of the resource for tagging and tracking"
  type        = string
  default     = "Arvindha"
}
