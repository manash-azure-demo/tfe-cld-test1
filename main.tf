# Reference to existing resource group
data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name  # Reference from variables
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "mkdVNet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

# Create a Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "mkdSubnet"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Network Security Group (NSG)
resource "azurerm_network_security_group" "nsg" {
  name                = "mkd-nsg"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create a Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = "mkd-vm1-ip"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  allocation_method   = "Static"
  domain_name_label   = "mkd-vm1"
  sku                 = "Standard"
}

# Create a Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "mkd-vm1-nic"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Create a Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "mkd-vm1"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  location            = data.azurerm_resource_group.existing_rg.location
  size                = "Standard_B2s"
  admin_username      = var.admin_username  # Reference from variables
  admin_password      = var.admin_password  # Reference from variables

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    name                 = "mkd-vm1-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name = "mkd-vm1"

  disable_password_authentication = false

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)  # Reference from variables
  }
}