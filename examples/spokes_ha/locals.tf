locals {
    subnetchunks = chunklist(slice(cidrsubnets(var.spoke_cidr, [for v in range(var.subnet_amount) : var.subnet_newbits]...), 2, length(cidrsubnets(var.spoke_cidr, [for v in range(var.subnet_amount) : var.subnet_newbits]...))), ((var.subnet_amount - 2) / 2))
}

