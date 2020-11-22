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
       "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File kickstart.ps1"
        

    }
  PROTECTED_SETTINGS


  settings = <<SETTINGS
 {
  "fileUris": [
                "https://gist.githubusercontent.com/bonnithedog/309069b9d15780fb6db8b1679f961544/raw/10be952c41670947d196e3157d098b74509858d8/kickstart-vm01a.ps1"
              ]  
}
  SETTINGS

  
  tags = {
    application = var.app_name
    environment = var.environment
  }

}

##############################################################################
# Outputs File
#
# Expose the outputs you want your users to see after a successful 
# `terraform apply` or `terraform output` command. You can add your own text 
# and include any data from the state file. Outputs are sorted alphabetically;
# use an underscore _ to move things to the bottom. 

output "windows_vm_public_ip" {
  value = azurerm_public_ip.web-windows-vm-ip
}