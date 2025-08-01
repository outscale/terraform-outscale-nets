output "net_id" {
  description = "The ID of the Outscale Net."
  value       = outscale_net.net.net_id
}

output "net_cidr_block" {
  description = "The CIDR block of the Outscale Net."
  value       = outscale_net.net.ip_range
}

output "public_subnets" {
  description = "List of public subnet IDs."
  value       = {for subnet in outscale_subnet.public_subnet : subnet.subnet_id => {az = subnet.subregion_name, cidr = subnet.ip_range}}
}

output "private_subnets" {
  description = "List of private subnet IDs."
  value       = {for subnet in outscale_subnet.private_subnet : subnet.subnet_id => {az = subnet.subregion_name, cidr = subnet.ip_range}}
}

output "public_ip_for_private_nat_serivce" {
  description = "List of public IPs for NAT service in private subnets."
  value       = [for ip in outscale_public_ip.nat_service_private_subnet_public_ip : ip.public_ip]
}

output "storage_subnet_ids" {
  description = "List of storage subnet IDs."
  value       = [for subnet in outscale_subnet.storage_subnet : subnet.subnet_id]
}

output "public_ip_for_storage_nat_service" {
  description = "List of public IPs for NAT service in storage subnets."
  value       = [for ip in outscale_public_ip.nat_service_storage_subnet_public_ip : ip.public_ip]
}