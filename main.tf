####################################################################################################################
# VPC
####################################################################################################################
resource "outscale_net" "net" {
  ip_range = var.cidr
  tenancy  = var.tenancy
  dynamic "tags" {
    for_each = concat(var.net_tags, var.tags, local.net_name)
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

####################################################################################################################
# public subnets & route tables
####################################################################################################################
resource "outscale_subnet" "public_subnet" {
  for_each = { for subnet in var.public_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet }

  net_id   = outscale_net.net.net_id
  ip_range = each.value.cidr

  subregion_name = each.key

  dynamic "tags" {
    for_each = concat(var.public_subnet_tags, var.tags, local.public_subnets_name[each.key])
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "outscale_route_table" "public_route_table" {
  for_each = { for subnet in var.public_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet }

  net_id = outscale_net.net.net_id

  dynamic "tags" {
    for_each = concat(var.tags, local.public_route_tables_name[each.key])
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "outscale_route_table_link" "public_route_table_link" {
  for_each = { for subnet in var.public_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet }

  route_table_id = outscale_route_table.public_route_table[each.key].route_table_id
  subnet_id      = outscale_subnet.public_subnet[each.key].subnet_id
}

####################################################################################################################
# private subnets, route tables, NAT service, public IPs & routes
####################################################################################################################
resource "outscale_subnet" "private_subnet" {
  for_each = { for subnet in var.private_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet }

  net_id   = outscale_net.net.net_id
  ip_range = each.value.cidr

  subregion_name = each.key

  dynamic "tags" {
    for_each = concat(var.private_subnet_tags, var.tags, local.private_subnets_name[each.key])
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "outscale_route_table" "private_route_table" {
  for_each = { for subnet in var.private_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet }

  net_id = outscale_net.net.net_id

  dynamic "tags" {
    for_each = concat(var.tags, local.private_route_tables_name[each.key])
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "outscale_route_table_link" "private_route_table_link" {
  for_each = { for subnet in var.private_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet }

  route_table_id = outscale_route_table.private_route_table[each.key].route_table_id
  subnet_id      = outscale_subnet.private_subnet[each.key].subnet_id
}

resource "outscale_public_ip" "nat_service_private_subnet_public_ip" {
  for_each = local.private_nat_gateways
  dynamic "tags" {
    for_each = concat(var.tags, local.private_nat_service_public_ip_name[each.key])
    content {
      key   = tags.value.key
      value = tags.value.value
    }

  }
}

resource "outscale_nat_service" "private_nat_service" {
  for_each = local.private_nat_gateways

  subnet_id    = outscale_subnet.public_subnet[each.key].subnet_id
  public_ip_id = outscale_public_ip.nat_service_private_subnet_public_ip[each.key].public_ip_id

  dynamic "tags" {
    for_each = concat(var.tags, local.private_nat_service_name[each.key])
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "outscale_route" "private_route_to_nat_service" {
  for_each = var.enable_private_subnets_nat_service ? { for subnet in var.private_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet } : {}

  destination_ip_range = "0.0.0.0/0"
  nat_service_id       = var.nat_service_per_private_subnet ? outscale_nat_service.private_nat_service[each.key].id : outscale_nat_service.private_nat_service[format("%s%s", var.outscale_region, local.fake_subnet[0].az)].nat_service_id
  route_table_id       = outscale_route_table.private_route_table[each.key].route_table_id
  depends_on           = [outscale_nat_service.private_nat_service]
}

####################################################################################################################
# Internet Service & Routes
####################################################################################################################
resource "outscale_internet_service" "internet_service" {
  count = var.enable_internet_service ? 1 : 0

  dynamic "tags" {
    for_each = concat(var.tags, local.internet_service_name)
    content {
      key   = tags.value.key
      value = tags.value.value
    }

  }
}

resource "outscale_internet_service_link" "internet_service_link" {
  count = var.enable_internet_service ? 1 : 0

  net_id              = outscale_net.net.net_id
  internet_service_id = outscale_internet_service.internet_service[0].internet_service_id
}

resource "outscale_route" "route_to_internet_service" {
  for_each = var.enable_internet_service ? { for subnet in var.public_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet } : {}

  destination_ip_range = "0.0.0.0/0"
  gateway_id           = outscale_internet_service.internet_service[0].internet_service_id
  route_table_id       = outscale_route_table.public_route_table[each.key].route_table_id
  depends_on           = [outscale_internet_service_link.internet_service_link]
}

####################################################################################################################
# storage subnets, route tables, NAT service, public IPs & routes
####################################################################################################################
resource "outscale_subnet" "storage_subnet" {
  for_each = { for subnet in var.storage_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet }

  net_id   = outscale_net.net.net_id
  ip_range = each.value.cidr

  subregion_name = each.key

  dynamic "tags" {
    for_each = concat(var.storage_subnet_tags, var.tags, local.storage_subnets_name[each.key])
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "outscale_route_table" "storage_route_table" {
  for_each = { for subnet in var.storage_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet }

  net_id = outscale_net.net.net_id

  dynamic "tags" {
    for_each = concat(var.tags, local.storage_route_tables_name[each.key])
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "outscale_route_table_link" "storage_route_table_link" {
  for_each = { for subnet in var.storage_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet }

  route_table_id = outscale_route_table.storage_route_table[each.key].route_table_id
  subnet_id      = outscale_subnet.storage_subnet[each.key].subnet_id
}

resource "outscale_public_ip" "nat_service_storage_subnet_public_ip" {
  for_each = local.storage_nat_gateways
  dynamic "tags" {
    for_each = concat(var.tags, local.storage_nat_service_public_ip_name[each.key])
    content {
      key   = tags.value.key
      value = tags.value.value
    }

  }
}

resource "outscale_nat_service" "storage_nat_service" {
  for_each = local.storage_nat_gateways

  subnet_id    = outscale_subnet.public_subnet[each.key].subnet_id
  public_ip_id = outscale_public_ip.nat_service_storage_subnet_public_ip[each.key].public_ip_id

  dynamic "tags" {
    for_each = concat(var.tags, local.storage_nat_service_name[each.key])
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "outscale_route" "storage_route_to_nat_service" {
  for_each = var.enable_storage_subnets_nat_service ? { for subnet in var.storage_subnets : format("%s%s", var.outscale_region, subnet.az) => subnet } : {}

  destination_ip_range = "0.0.0.0/0"
  nat_service_id       = var.nat_service_per_storage_subnet ? outscale_nat_service.storage_nat_service[each.key].id : outscale_nat_service.storage_nat_service[format("%s%s", var.outscale_region, local.fake_subnet[0].az)].nat_service_id
  route_table_id       = outscale_route_table.storage_route_table[each.key].route_table_id
  depends_on           = [outscale_nat_service.storage_nat_service]
}