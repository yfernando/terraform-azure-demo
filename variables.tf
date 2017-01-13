variable "subscription_id" {
  description = ""
}

variable "client_id" {
  description = ""
}

variable "client_secret" {
  description = ""
}

variable "tenant_id" {
   description = ""
}

variable "location" {
  default = "northeurope"
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "vm_size" {
  default = "Standard_A0"
}

variable "vm_image_publisher" {
  default = "Canonical"
}

variable "vm_image_offer" {
  default = "UbuntuServer"
}

variable "vm_image_sku" {
  default = "16.04-LTS"
}
