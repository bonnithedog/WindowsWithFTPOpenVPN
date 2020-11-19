
# Windows Web VM Admin User
variable "web-windows-admin-username" {
  type        = string
  description = "Windows Web VM Admin User"
  #default     = "*********"
}
# Windows Web VM Admin Password
variable "web-windows-admin-password" {
  type        = string
  description = "Windows Web VM Admin Password"
  #default     = "***********"
}
# Windows web VM Virtual Machine Size
variable "web-windows-vm-size" {
  type        = string
  description = "Windows Web VM Size"

                #Standard_B1ls 
                #Standard_B1s 
                #Standard_B1ms
                #Standard_B2s 
                #Standard_B2ms
                #Standard_B4ms
                #Standard_B8ms
                #Standard_DS3_v2
  #default     = "Standard_B1ls"
}
variable "web-windows-delete-os-disk-on-termination" {
  type        = string
  description = "Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed?"
  default     = "false"  # Update for your environment
}
variable "web-windows-delete-data-disks-on-termination" {
  description = "Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed?"
  type        = string
  default     = "false" # Update for your environment
}
##############
## OS Image ##
##############
# Windows Server 2019 SKU used to build VMs
variable "windows-2019-sku" {
  type        = string
  description = "Windows Server 2019 SKU used to build VMs"
  default     = "2019-Datacenter"
}
# Windows Server 2016 SKU used to build VMs
variable "windows-2016-sku" {
  type        = string
  description = "Windows Server 2016 SKU used to build VMs"
  default     = "2016-Datacenter"
}
# Windows Server 2012 R2 SKU used to build VMs
variable "windows-2012-sku" {
  type        = string
  description = "Windows Server 2012 R2 SKU used to build VMs"
  default     = "2012-R2-Datacenter"
}
