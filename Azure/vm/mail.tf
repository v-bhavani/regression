provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-demo"
    storage_account_name = "testcloud001423"
    container_name      = "tfstate"
    key                 = "mainstate.tfstate"
  }
}

# Use existing VNet & Subnet
data "azurerm_virtual_network" "existing_vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = var.resource_group_name
}

# Public IP
resource "azurerm_public_ip" "vm_ip" {
  name                = "${var.vm_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# NIC
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_ip.id
  }
}

# Linux VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.vm_nic.id]
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  computer_name                   = var.vm_name

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  tags = {
    Project          = var.project
    Duration         = var.duration
    Owner            = var.owner
    "Resource Holder" = var.Holder
  }
}

# Independent Data Disks (created but not automatically attached)
resource "azurerm_managed_disk" "data_disks" {
  for_each             = var.data_disks
  name                 = each.value.disk_name != "" ? each.value.disk_name : "${var.vm_name}-datadisk-${each.key}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = each.value.disk_type
  create_option        = "Empty"
  disk_size_gb         = each.value.disk_size

  tags = {
    ManagedByTerraform = "true"
    DiskID             = each.key
  }
}

# Optional Disk Attachment (explicitly controlled)
resource "azurerm_virtual_machine_data_disk_attachment" "disk_attach" {
  for_each           = var.attached_disks
  managed_disk_id    = azurerm_managed_disk.data_disks[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = each.value.lun
  caching            = each.value.caching
}
