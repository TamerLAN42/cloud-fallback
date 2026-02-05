module "network" {
  source = "./modules/tf-yc-network"
}

module "instance" {
  source				= "./modules/tf-yc-instance"
  instance_name			= var.instance_name
  disk_size				= var.disk_size
  instance_zone			= var.instance_zone
  platform_id			= var.platform_id
  image_id				= var.image_id
  scheduling_preemptible = var.scheduling_preemptible
  subnet_id				= module.network.vpc_subnet_ids[var.instance_zone]
  nat = var.nat
}

output "internal_ip" {
	value = module.instance.internal_ip_address
	description = "Внутренний IP"
}

output "external_ip" {
	value = module.instance.external_ip_address
	description = "Внешний IP"
}

resource "local_file" "ansible_inventory" {
        content = "${module.instance.external_ip_address}"
        filename = "/shared/hosts.ini"
}
