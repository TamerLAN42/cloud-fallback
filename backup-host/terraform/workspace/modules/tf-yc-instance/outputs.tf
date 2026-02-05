output "internal_ip_address" {
    value = yandex_compute_instance.vm-1.network_interface.0.ip_address
	description = "Private ip address (inside the cloud) of vm"
}
output "external_ip_address" {
    value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
	description = "Public ip address for brutforcing by bots"
}