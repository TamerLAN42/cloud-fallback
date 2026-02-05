output "vpc_network_id" {
  value       = data.yandex_vpc_network.default.id
  description = "ID of the default VPC network"
}

output "vpc_subnet_ids" {
  value       = { for zone, subnet in data.yandex_vpc_subnet.zone_subnets : zone => subnet.id }
  description = "Map of subnet IDs by zone"
}