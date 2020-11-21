# Generate randon name for virtual machine
resource "random_string" "random-win-vm01" {
  length  = 8
  special = false
  lower   = true
  upper   = false
  number  = true
}

# Get a Static Public IP for web
resource "azurerm_public_ip" "web-windows-vm-ip" {
  name = "win-${random_string.random-win-vm01.result}-vm-ip"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method   = "Static"
  
  tags = { 
    application = var.app_name
    environment = var.environment 
  }
}

# Create Network Card for web VM
resource "azurerm_network_interface" "web-windows-vm-nic" {
  depends_on=[azurerm_public_ip.web-windows-vm-ip]
  name = "win-${random_string.random-win-vm01.result}-vm-nic"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.web-windows-vm-ip.id
  }
  tags = { 
    application = var.app_name
    environment = var.environment 
  }
}

# Create Windows web Server
resource "azurerm_windows_virtual_machine" "web-windows-vm" {
  depends_on=[azurerm_network_interface.web-windows-vm-nic]
  name = "win-${random_string.random-win-vm01.result}-vm"
  location              = azurerm_resource_group.network-rg.location
  resource_group_name   = azurerm_resource_group.network-rg.name
  size                  = var.web-windows-vm-size
  network_interface_ids = [azurerm_network_interface.web-windows-vm-nic.id]
  
  computer_name = "win-${random_string.random-win-vm01.result}-vm"
  admin_username = var.web-windows-admin-username
  admin_password = var.web-windows-admin-password
  os_disk {
    name = "win-${random_string.random-win-vm01.result}-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows-2019-sku
    version   = "latest"
  }
  enable_automatic_updates = true
  provision_vm_agent       = true
  tags = {
    application = var.app_name
    environment = var.environment 
  }
}

#Install local software

# Virtual Machine Extension to Install Requierd software
  resource "azurerm_virtual_machine_extension" "Install-Requierd-Software" {
  depends_on=[azurerm_windows_virtual_machine.web-windows-vm]
  name = "win-${random_string.random-win-vm01.result}-vm-extension"
  virtual_machine_id = azurerm_windows_virtual_machine.web-windows-vm.id
  publisher = "Microsoft.Compute"
  type = "CustomScriptExtension"
  type_handler_version = "1.9"




protected_settings = <<PROTECTED_SETTINGS
    {
       "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File openvpn.ps1"
        ,
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ftp-install-configure.ps1"

    }
  PROTECTED_SETTINGS


  settings = <<SETTINGS
 {
  "fileUris": [
                "https://gist.githubusercontent.com/bonnithedog/753858a5cfcb1b99ca1427ef37de6b22/raw/64fc3b81681e02d22025c38df8eb68f3217706d4/openvpn.ps1"
                ,
                "https://gist.githubusercontent.com/bonnithedog/f51abfa76fa81af83acd81f653cf58ab/raw/20aa11f2a1f96af0926725acf223cb05b88bb6cc/ftp-install-configure.ps1"
]
}
  SETTINGS

  
  tags = {
    application = var.app_name
    environment = var.environment
  }
}

