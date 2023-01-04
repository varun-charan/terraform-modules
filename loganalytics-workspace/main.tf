resource "azurerm_log_analytics_workspace" "log_workspace" {
  for_each            = (var.log_workspace_map == null ? {} : var.log_workspace_map)
  name                = each.key
  resource_group_name = each.value.resource_group

  # If location is not defined in resource_group_map, then use "northeurope" as default.
  location          = coalesce(each.value.location, "northeurope")
  sku               = coalesce(each.value.sku, "PerGB2018")
  retention_in_days = coalesce(each.value.retention_in_days, "30")

  tags = merge(local.tf_tags, each.value.custom_tags)
}

# Create a Resource Group if it doesn’t exist
resource "azurerm_resource_group" "tfexample" {
  name     = "my-terraform-rg"
  location = "West Europe"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "tfexample" {
  name                = "my-terraform-vnet"
  location            = azurerm_resource_group.tfexample.location
  resource_group_name = azurerm_resource_group.tfexample.name
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet in the Virtual Network
resource "azurerm_subnet" "tfexample" {
  name                 = "my-terraform-subnet"
  resource_group_name  = azurerm_resource_group.tfexample.name
  virtual_network_name = azurerm_virtual_network.tfexample.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a Network Interface
resource "azurerm_network_interface" "tfexample" {
  name                = "my-terraform-nic"
  location            = azurerm_resource_group.tfexample.location
  resource_group_name = azurerm_resource_group.tfexample.name

  ip_configuration {
    name                          = "my-terraform-nic-ip-config"
    subnet_id                     = azurerm_subnet.tfexample.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a Virtual Machine
resource "azurerm_linux_virtual_machine" "tfexample" {
  name                            = "my-terraform-vm"
  location                        = azurerm_resource_group.tfexample.location
  resource_group_name             = azurerm_resource_group.tfexample.name
  network_interface_ids           = [azurerm_network_interface.tfexample.id]
  size                            = "Standard_DS1_v2"
  computer_name                   = "myvm"
  admin_username                  = "azureuser"
  admin_password                  = "Password1234!"
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    name                 = "my-terraform-os-disk"
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}