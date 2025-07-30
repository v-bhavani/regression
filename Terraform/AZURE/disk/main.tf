provider "azurerm" {
  features {}
  subscription_id = "bf18f464-1469-4216-834f-9c6694dbfe26"
}

terraform {
  backend "azurerm"{
    resource_group_name = "cloud-demo"
    storage_account_name = "testcloud001423"
    container_name = "terraform"
    key = "disk123.tfstate"
 }
}

resource "azurerm_managed_disk" "example" {
  name                 = var.diskname
  location             = var.location
  resource_group_name  = var.resourcegroup
  storage_account_type = var.st_acc_type
  create_option        = "Empty"
  disk_size_gb         = var.disktype

  tags = {
    Project  = var.project
    Duration = var.duration
    Owner    = var.owner
  }
}
