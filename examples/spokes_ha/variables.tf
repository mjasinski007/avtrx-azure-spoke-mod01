variable "ctrl_username" {
    type = string
}

variable "ctrl_password" {
    type = string
}

variable "ctrl_ip" {
    type = string
}

variable "env_tag" {
    type = string
}

variable "spoke_basename" {
    type = string
}

variable "gateway_basename" {
    type = string
}

variable "vnet_basename" {
    type = string
}

variable "rg_basename" {
    type = string
}

variable "location_short_weu" {
    type = string
}

variable "tag_cmdbServiceCi" {
    type = string
}

variable "tag_costCenter" {
    type = string
}

variable "tag_serviceName" {
    type = string
}

variable "tag_Environment" {
    type = string
}

variable "tag_ownerUPN" {
    type = string
}

variable "tag_ownerName" {
    type = string
}

variable "spoke_client_id" {
    type = string

}

variable "spoke_environment_type" {
    type = string
}

variable "spoke_company" {
    type = string
}

variable "spoke_cloudplatform" {
    type = string
}

variable "spoke_shortLocation" {
    type = string
}

variable "spoke_serviceShort" {
    type = string
}

variable "spoke_location" {
    type = string
}

variable "spoke_cidr" {
    type = string
}

variable "subnet_amount" {
    type = number
}

variable "subnet_newbits" {
    type = number
}

variable "spoke_dns_servers" {
    type = list(string)
}

variable "spoke_single_az_hagw" {
    type = bool
}
variable "spoke_gw_subnet_cidr" {
    type = string
}

variable "spoke_gw_subnet_cidr_hagw" {
    type = string
}

variable "azure_ctrl_account_name" {
    type = string
}

variable "azure_subscription_id" {
    type = string
}

variable "azure_client_id" {
    type = string
}

variable "azure_client_secret" {
    type = string
}

variable "azure_tenant_id" {
    type = string
}

