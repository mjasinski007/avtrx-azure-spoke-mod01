ctrl_username         = "admin"
ctrl_password         = "Its@secret!23"
ctrl_ip               = "3.10.92.20"

azure_ctrl_account_name   = "avtx_azure_account"


#General config
env_tag = "aviatrix-resource"

# Short names
spoke_basename    = "spk"
gateway_basename  = "tgw"
vnet_basename     = "vnet"
rg_basename       = "rg"

## Locations
location_short_weu  = "weu1"

# Tags
tag_cmdbServiceCi  = "Network"
tag_costCenter     = "Group IT - ID"
tag_serviceName    = "Aviatrix"
tag_Environment    = "Production"
tag_ownerUPN       = "mjasinski@aviatrix.com"
tag_ownerName      = "vMario"


azure_subscription_id = "46604b85-cf80-46e4-9117-10f9000797f9"
azure_client_id       = "b76ef98d-276e-4627-9c22-7136073d4d51"
azure_client_secret   = "A6f7Q~XRy4q4GBnOYaDZiBQDJtg5KmlLyZyun"
azure_tenant_id       = "4780055e-ce37-4f02-b33d-fdad8493a4b6"
spoke_client_id       = "b76ef98d-276e-4627-9c22-7136073d4d51"


spoke_serviceShort        = "avtrx"
spoke_cloudplatform       = "azm"
spoke_shortLocation       = "weu"
spoke_company             = "vdevnet1"
spoke_environment_type     = "prod"




spoke_location            = "West Europe"
spoke_cidr                = "172.27.164.0/22"
subnet_amount             = 8
subnet_newbits            = 3
spoke_dns_servers         = ["10.111.160.21", "10.111.160.22"]
spoke_single_az_hagw      = false
spoke_gw_subnet_cidr      = "172.27.164.0/27"
spoke_gw_subnet_cidr_hagw = "172.27.164.32/27"