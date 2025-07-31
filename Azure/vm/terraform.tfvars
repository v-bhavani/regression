resource_group_name = "CLOUD-DEMO"
location            = "East US"
vnet_name           = "asr-vm-vnet"
subnet_name         = "default"
vm_name             = "vm-demo"
vm_size             = "Standard_B1s"
admin_username      = "azureuser"
admin_password      = "Password@1234"
os_disk_type        = "Standard_LRS"
project             = "Symphony"
duration            = "6 months"
owner               = "Soundhar"
Holder              = "BCS Cloud Team"
subscription_id     = "bf18f464-1469-4216-834f-9c6694dbfe26"

data_disks = {
  disk1 = {
    disk_size = 10
    disk_type = "Standard_LRS"
    disk_name = "my-custom-disk-01"
  }
#  disk2 = {
#    disk_size = 20
#    disk_type = "Standard_LRS"
#    disk_name = "my-custom-disk-02"
#  }
}

# Only attach disk1 by default
attached_disks = {
  disk1 = {
    lun     = 2
    caching = "ReadWrite"
  }
}
