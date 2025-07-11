locals {
  fake_subnet = [{ "cidr" : "", "az" : "a" }]

  ####################################################################################################################
  # Define if the net (VPC) is a name in the tags
  ####################################################################################################################
  net_name_in_tags = length(var.net_tags) > 0 && alltrue([for tag in var.net_tags : tag.key == "Name"]) ? true : false

  net_name = local.net_name_in_tags ? [] : [{
    key   = "Name"
    value = var.name != "" ? var.name : format("net-%s", var.outscale_region)
  }]

  ####################################################################################################################
  # Define if the subnets are a name in the tags
  ####################################################################################################################
  public_subnet_name_in_tags  = length(var.public_subnet_tags) > 0 && alltrue([for tag in var.public_subnet_tags : tag.key == "Name"]) ? true : false
  private_subnet_name_in_tags = length(var.private_subnet_tags) > 0 && alltrue([for tag in var.private_subnet_tags : tag.key == "Name"]) ? true : false
  storage_subnet_name_in_tags = length(var.storage_subnet_tags) > 0 && alltrue([for tag in var.storage_subnet_tags : tag.key == "Name"]) ? true : false

  public_subnets_name = local.public_subnet_name_in_tags ? {} : {
    for subnet in var.public_subnets : format("%s%s", var.outscale_region, subnet.az) => [{
      key   = "Name"
      value = format("%s-public-subnet-%s%s", var.name, var.outscale_region, subnet.az)
    }]
  }

  private_subnets_name = local.private_subnet_name_in_tags ? {} : {
    for subnet in var.private_subnets : format("%s%s", var.outscale_region, subnet.az) => [{
      key   = "Name"
      value = format("%s-private-subnet-%s%s", var.name, var.outscale_region, subnet.az)
    }]
  }

  storage_subnets_name = local.storage_subnet_name_in_tags ? {} : {
    for subnet in var.storage_subnets : format("%s%s", var.outscale_region, subnet.az) => [{
      key   = "Name"
      value = format("%s-storage-subnet-%s%s", var.name, var.outscale_region, subnet.az)
    }]
  }

  ####################################################################################################################
  # Define if the internet service is a name in the tags
  ####################################################################################################################
  internet_service_name_in_tags = length(var.internet_service_tags) > 0 && alltrue([for tag in var.internet_service_tags : tag.key == "Name"]) ? true : false
  internet_service_name = local.internet_service_name_in_tags ? [] : [{
    key   = "Name"
    value = format("%s-internet-service-%s", var.name, var.outscale_region)
  }]

  ####################################################################################################################
  # Private Nat Service, Public IPs & Routes
  ####################################################################################################################
  # list the number of NAT gateways to create
  private_nat_gateways = var.enable_private_subnets_nat_service ? var.nat_service_per_private_subnet ? { for subnet in var.private_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet } : { for subnet in local.fake_subnet : format("%s%s", var.outscale_region, subnet.az) => subnet } : {}

  # define if the NAT service is a name in the tags
  private_nat_service_name_in_tags = length(var.private_nat_gateway_tags) > 0 && alltrue([for tag in var.private_nat_gateway_tags : tag.key == "Name"]) ? true : false

  # define the NAT service name in tags
  private_nat_service_name = local.private_nat_service_name_in_tags ? {} : {
    for subnet in var.private_subnets : format("%s%s", var.outscale_region, subnet.az) => [{
      key   = "Name"
      value = format("%s-nat-service-%s%s", var.name, var.outscale_region, subnet.az)
    }]
  }

  # define the NAT service public IP name in tags
  private_nat_service_public_ip_name = local.private_nat_service_name_in_tags ? {} : {
    for subnet in var.private_subnets : format("%s%s", var.outscale_region, subnet.az) => [{
      key   = "Name"
      value = format("%s-nat-service-public-ip-%s%s", var.name, var.outscale_region, subnet.az)
    }]
  }


  ####################################################################################################################
  # Storage Nat Service, Public IPs & Routes
  ####################################################################################################################
  # list the number of NAT gateways to create
  storage_nat_gateways = var.enable_storage_subnets_nat_service ? var.nat_service_per_storage_subnet ? { for subnet in var.storage_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet } : { for subnet in local.fake_subnet : format("%s%s", var.outscale_region, subnet.az) => subnet } : {}

  # define if the NAT service is a name in the tags
  storage_nat_service_name_in_tags = length(var.storage_nat_gateway_tags) > 0 && alltrue([for tag in var.storage_nat_gateway_tags : tag.key == "Name"]) ? true : false

  # define the NAT service name in tags
  storage_nat_service_name = local.storage_nat_service_name_in_tags ? {} : {
    for subnet in var.storage_subnets : format("%s%s", var.outscale_region, subnet.az) => [{
      key   = "Name"
      value = format("%s-storage-nat-service-%s%s", var.name, var.outscale_region, subnet.az)
    }]
  }

  # define the NAT service public IP name in tags
  storage_nat_service_public_ip_name = local.storage_nat_service_name_in_tags ? {} : {
    for subnet in var.storage_subnets : format("%s%s", var.outscale_region, subnet.az) => [{
      key   = "Name"
      value = format("%s-storage-nat-service-public-ip-%s%s", var.name, var.outscale_region, subnet.az)
    }]
  }
}

