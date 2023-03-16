
data "azurerm_client_config" "current" {}


##############################################
### Create New Aviatrix Account, if needed ###
##############################################

/* resource "aviatrix_account" "azm_avx" {
    account_name        = "${var.spoke_cloudplatform}-avx-${var.spoke_company}-${var.spoke_shortLocation}-${var.spoke_environment_type}-${var.spoke_serviceShort}"
    cloud_type          = 8
    arm_subscription_id = data.azurerm_client_config.current.subscription_id
    arm_directory_id    = data.azurerm_client_config.current.tenant_id
    arm_application_id  = var.azure_client_id
    arm_application_key = data.azurerm_key_vault_secret.aviatrix.value
} */

#############################
### Create Aviatrix Spoke ###
#############################


module "avx_spoke" {
    source              = "../../"
    region              = var.spoke_location
    resource_group      = "${var.spoke_serviceShort}-${var.spoke_cloudplatform}-${var.spoke_shortLocation}-${var.spoke_company}-${var.spoke_environment_type}-${var.spoke_basename}-${var.rg_basename}"
    account             = var.azure_ctrl_account_name
    vnet_cidr           = var.spoke_cidr
    spoke_dns_servers   = tolist(var.spoke_dns_servers)
    gw_name             = "${var.spoke_serviceShort}-${var.spoke_cloudplatform}-${var.spoke_shortLocation}-${var.spoke_company}-${var.spoke_environment_type}-${var.spoke_basename}"
    vnet_name           = "${var.spoke_serviceShort}-${var.spoke_cloudplatform}-${var.spoke_shortLocation}-${var.spoke_company}-${var.spoke_environment_type}-${var.vnet_basename}"
    gw_subnet_cidr      = var.spoke_gw_subnet_cidr
    gw_subnet_cidr_hagw = var.spoke_gw_subnet_cidr_hagw
    single_az_ha        = var.spoke_single_az_hagw
    tag_list = tomap({
        "cmdbServiceCi" = var.tag_cmdbServiceCi
        "costCenter"    = var.tag_costCenter
        "ServiceName"   = var.tag_serviceName
        "Environment"   = var.tag_Environment
        "ownerUPN"      = var.tag_ownerUPN
        "ownerName"     = var.tag_ownerName
    })
}

###################################################
### Create Additional Subnets and Route Tables ####
###################################################

resource "azurerm_subnet" "subnets0" {
    for_each             = toset(local.subnetchunks[0])
    name                 = "az-subnet-${index(local.subnetchunks[0], each.key)}"
    resource_group_name  = module.avx_spoke.azure_rg.name
    virtual_network_name = module.avx_spoke.vnet.name
    address_prefixes     = [each.value]
}

resource "azurerm_subnet" "subnets1" {
    for_each             = toset(local.subnetchunks[1])
    name                 = "az-subnet-${index(local.subnetchunks[1], each.key) + ((var.subnet_amount - 2) / 2)}"
    resource_group_name  = module.avx_spoke.azure_rg.name
    virtual_network_name = module.avx_spoke.vnet.name
    address_prefixes     = [each.value]
}

resource "azurerm_subnet_route_table_association" "subnet_to_rt1" {
    for_each       = azurerm_subnet.subnets0
    subnet_id      = azurerm_subnet.subnets0[each.key].id
    route_table_id = module.avx_spoke.route_table_1
}

resource "azurerm_subnet_route_table_association" "subnet_to_rt2" {
    for_each       = azurerm_subnet.subnets1
    subnet_id      = azurerm_subnet.subnets1[each.key].id
    route_table_id = module.avx_spoke.route_table_2
}

###################################
### Spoke to Transit Attchament ###
###################################

# Spoke Attachment to Transit
/* resource "aviatrix_spoke_transit_attachment" "avx_spoke_gw_att" {
    spoke_gw_name   = module.spoke.aviatrix_spoke_gateway.gw_name
    #transit_gw_name = data.terraform_remote_state.transit.outputs.a-azm-seas-transit-gw-name
    transit_gw_name = 
    depends_on      = [azurerm_subnet_route_table_association.subnet_to_rt1, azurerm_subnet_route_table_association.subnet_to_rt2] # Create Spoke attachment AFTER route table associations
} */



