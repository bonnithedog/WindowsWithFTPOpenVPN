

## Variables for the network setup


variable "network-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
  default = "10.0.0.0/16"
}
variable "network-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
  default = "10.0.1.0/24"
}