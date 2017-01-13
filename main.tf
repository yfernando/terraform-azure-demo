# 1. Configure the Microsoft Azure Provider
# This is also called the `service principal`
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"

}

# 2. Create a resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg_demo"
    location = "${var.location}"

}

# 3. Create a virtual network in the resource group
resource "azurerm_virtual_network" "network" {
  name                = "vnet_demo"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${var.location}"

}

# 4. Create a subnet in the virtual netowork
resource "azurerm_subnet" "subnet_web" {
  name                 = "subnet_web_demo"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.0.1.0/24"

}

# 5. Create a subnet in the virtual netowork
resource "azurerm_subnet" "subnet_app" {
  name                 = "subnet_app_demo"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.0.2.0/24"

}

# 6. Create a subnet in the virtual netowork
resource "azurerm_subnet" "subnet_db" {
  name                 = "subnet_db_demo"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.0.3.0/24"

}

# 7. Create netowork interface in web subnet
resource "azurerm_network_interface" "network_interface" {
  name                = "net_int_demo"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  ip_configuration {
    name                          = "ip_config_demo"
    subnet_id                     = "${azurerm_subnet.subnet_web.id}"
    private_ip_address_allocation = "dynamic"
  }

}

# 8. Create storage account in the resource group
resource "azurerm_storage_account" "st_account" {
    name                = "stacctdemo"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    location            = "${var.location}"
    account_type        = "${var.storage_account_type}"

}

# 9. Create storage container in the storage account
resource "azurerm_storage_container" "st_container" {
  name                  = "st-cont-demo"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  storage_account_name  = "${azurerm_storage_account.st_account.name}"
  container_access_type = "private"
}

# Step 6. Create the virtual machine
resource "azurerm_virtual_machine" "vm" {
  name                  = "vm_demo"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.network_interface.id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "${var.vm_image_publisher}"
    offer     = "${var.vm_image_offer}"
    sku       = "${var.vm_image_sku}"
    version   = "latest"
  }

  storage_os_disk {
    name          = "demodisk1"
    vhd_uri       = "${azurerm_storage_account.st_account.primary_blob_endpoint}${azurerm_storage_container.st_container.name}/demodisk1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }


  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }


}
