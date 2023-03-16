# Resource Group for Spoke Vnet and AVX Spoke GW
resource "azurerm_resource_group" "avx_spoke_rg" {
    name     = var.resource_group
    location = var.region
    tags     = var.tag_list
}


# Vnet for Spoke Vnet and AVX Spoke GW
resource "azurerm_virtual_network" "avx_spoke_vnet" {
    name                = var.vnet_name
    location            = azurerm_resource_group.avx_spoke_rg.location
    resource_group_name = azurerm_resource_group.avx_spoke_rg.name
    address_space       = [var.vnet_cidr]
    dns_servers         = var.spoke_dns_servers
}


# Public Subnet for AVX Spoke GW. Please use subnet length /26 - /28
resource "azurerm_subnet" "avx_gateway_subnet" {
    name                 = "avx-gateway-subnet"
    resource_group_name  = azurerm_resource_group.avx_spoke_rg.name
    virtual_network_name = azurerm_virtual_network.avx_spoke_vnet.name
    address_prefixes     = [var.gw_subnet_cidr]
}

resource "azurerm_subnet" "avx_gateway_subnet_hagw" {
    name                 = "avx-gateway-subnet-hagw"
    resource_group_name  = azurerm_resource_group.avx_spoke_rg.name
    virtual_network_name = azurerm_virtual_network.avx_spoke_vnet.name
    address_prefixes     = [var.gw_subnet_cidr_hagw]
}

resource "azurerm_route_table" "vm_azure_rt1" {
    name = "${var.vnet_name}-rt1"
    location            = azurerm_resource_group.avx_spoke_rg.location
    resource_group_name = azurerm_resource_group.avx_spoke_rg.name

    route {
        name           = "blackhole"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "None" # this is required for Central Egress
    }

    lifecycle { # AVX Controller adds routes
        ignore_changes = [route]
    }

    depends_on = [
        azurerm_subnet.avx_gateway_subnet
    ]
}

resource "azurerm_route_table" "vm_azure_rt2" {
    name                = "${var.vnet_name}-rt2"
    location            = azurerm_resource_group.avx_spoke_rg.location
    resource_group_name = azurerm_resource_group.avx_spoke_rg.name

    route {
        name           = "blackhole"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "None" # this is required for Central Egress
    }

    lifecycle { # AVX Controller adds routes
        ignore_changes = [route]
    }

    depends_on = [
        azurerm_subnet.avx_gateway_subnet_hagw
    ]
}

# Aviatrix Spoke GW

resource "aviatrix_spoke_gateway" "avx_spoke_gw" {
    cloud_type                        = 8
    account_name                      = var.account
    gw_name                           = var.gw_name
    vpc_id                            = "${azurerm_virtual_network.avx_spoke_vnet.name}:${azurerm_resource_group.avx_spoke_rg.name}"
    vpc_reg                           = var.region
    gw_size                           = var.instance_size
    ha_gw_size                        = var.ha_gw ? var.instance_size : null
    subnet                            = azurerm_subnet.avx_gateway_subnet.address_prefixes[0]
    ha_subnet                         = var.ha_gw ? azurerm_subnet.avx_gateway_subnet_hagw.address_prefixes[0] : null
    insane_mode                       = var.insane_mode
    single_az_ha                      = var.single_az_ha
    single_ip_snat                    = var.single_ip_snat
    customized_spoke_vpc_routes       = var.customized_spoke_vpc_routes
    filtered_spoke_vpc_routes         = var.filtered_spoke_vpc_routes
    included_advertised_spoke_routes  = var.included_advertised_spoke_routes
    zone                              = var.ha_gw ? (var.single_az_ha ? null : "az-1") : null
    ha_zone                           = var.ha_gw ? (var.single_az_ha ? null : "az-2") : null
}