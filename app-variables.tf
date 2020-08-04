# company name 
variable "company" {
  type        = string
  description = "The company name used to build resources"
  default = "Bauer"
}
# application name 
variable "app_name" {
  type        = string
  description = "The application name used to build resources"
  default = "synctogooglepic"
}
# environment
variable "environment" {
  type        = string
  description = "The environment to be built"
  default = "prod"
}
# azure region
variable "location" {
  type        = string
  description = "Azure region where the resources will be created"
  default     = "north europe"
}