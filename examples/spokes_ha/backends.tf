terraform {
    backend "azurerm" {
        resource_group_name  = "tfstate-rg"
        storage_account_name = "tfstate8797996"
        container_name       = "tfstate"
        key                  = "vdevnet_spk.transit.terraform.tfstate"
    }
}