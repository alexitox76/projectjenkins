variable "company" {
    type = string
    description = "This variable defines the name of the company"  
}

variable "environment" {
    type = string
    description = "This variable defines the environment to be built"
  
}

variable "location" {
    type = string
    description = "Azure region where the resource group will be created"
    default = "East US"
  
}