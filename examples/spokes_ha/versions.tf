terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.0.0"
        }
        aviatrix = {
            source  = "AviatrixSystems/aviatrix"
            version = "~>3.0.0"       # Used for Controller 7.x
        }
    }
    required_version = ">= 1.0"
}