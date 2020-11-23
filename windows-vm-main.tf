# Create Network Security Group to Access web VM from Internet
resource "azurerm_network_security_group" "web-windows-vm-nsg" {
  name = "${var.app_name}-${var.environment}-web-windows-vm-nsg"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

 security_rule {
   name                       = "allow-rdp"
   description                = "allow-rdp"
   priority                   = 100
   direction                  = "Inbound"
   access                     = "Block"
   protocol                   = "Tcp"
   source_port_range          = "*"
   destination_port_range     = "3389"
   source_address_prefix      = "Internet"
   destination_address_prefix = "*" 
 }

  #security_rule {
  #  name                       = "allow-http"
  #  description                = "allow-http"
  #  priority                   = 110
  #  direction                  = "Inbound"
  #  access                     = "Allow"
  #  protocol                   = "Tcp"
  #  source_port_range          = "*"
  #  destination_port_range     = "80"
  #  source_address_prefix      = "Internet"
  #  destination_address_prefix = "*"
  #}

  #security_rule {
  #  name                       = "allow-pptp"
  #  description                = "allow-pptp"
  #  priority                   = 120
  #  direction                  = "Inbound"
  #  access                     = "Allow"
  #  protocol                   = "Tcp"
  #  source_port_range          = "*"
  #  destination_port_range     = "1723"
  #  source_address_prefix      = "Internet"
  #  destination_address_prefix = "*"
  #}

  security_rule {
    name                       = "FTP-Passive-Traffic-In"
    description                = "FTP Passive Traffic-In"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1024-65535"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "allow-FTP"
    description                = "allow-FTP"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "21"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }


    security_rule {
    name                       = "FTP-SSL-Traffic-In"
    description                = "FTP SSL Traffic-In"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "990"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "FTP-Passive"
    description                = "FTP-Passive"
    priority                   = 160
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "50000-51000"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }


  tags = {
    application = var.app_name
    environment = var.environment 
  }
}
# Associate the web NSG with the Subnet
resource "azurerm_subnet_network_security_group_association" "web-windows-vm-nsg-association" {
  depends_on=[azurerm_network_security_group.web-windows-vm-nsg]
  subnet_id                 = azurerm_subnet.network-subnet.id
  network_security_group_id = azurerm_network_security_group.web-windows-vm-nsg.id
}




