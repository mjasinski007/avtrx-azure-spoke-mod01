data "azurerm_client_config" "current" {}





/* # Read transit state file. Aviatrix transit must be deployed first
data "terraform_remote_state" "transit" {
    backend = "azurerm"
    config = {
        resource_group_name  = var.remote_state_resource_group_name
        storage_account_name = var.remote_state_storage_account_name
        container_name       = "tfstate"
        key                  = var.remote_state_transit_file_name
    }
}


# Read segmentation state file. Aviatrix segmentation  must be deployed first
data "terraform_remote_state" "segmentation_domain" {
    backend = "azurerm"
    config = {
        resource_group_name  = var.remote_state_resource_group_name
        torage_account_name  = var.remote_state_storage_account_name
        container_name       = "tfstate"
        key                  = var.remote_state_segmentation_domain_file_name
    }
} */
