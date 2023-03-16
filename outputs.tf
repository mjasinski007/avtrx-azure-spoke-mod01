output "vnet" {
    description = "The created VNET with all of it's attributes"
    value       = azurerm_virtual_network.avx_spoke_vnet
}

output "aviatrix_spoke_gateway" {
    description = "The Aviatrix spoke gateway object with all of it's attributes"
    value       = aviatrix_spoke_gateway.avx_spoke_gw
    sensitive   = true
}

output "azure_rg" {
    description = "Azure resource group"
    value       = azurerm_resource_group.avx_spoke_rg
}

output "route_table_1" {
    description = "ID of route table 1"
    value       = azurerm_route_table.vm_azure_rt1.id
}

output "route_table_2" {
    description = "ID of route table 2"
    value       = azurerm_route_table.vm_azure_rt2.id
}
