resource "yandex_compute_instance" "vm-1" {
    name = var.instance_name
    zone = var.instance_zone
	platform_id = var.platform_id
	scheduling_policy { preemptible = var.scheduling_preemptible }
	
    # Конфигурация ресурсов:
    resources {
        cores  = 2
        memory = 2
    }

    # Загрузочный диск:
    boot_disk {
        initialize_params {
            image_id = var.image_id
			size = var.disk_size
        }
    }

    # Сетевой интерфейс:
    network_interface {
        subnet_id = var.subnet_id
        nat       = var.nat
    }

    # Метаданные машины:
    metadata = {
		ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
        user-data = file("${path.module}/cloud-init.yaml")
    }
	
	connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("~/.ssh/id_ed25519")
        host        = self.network_interface[0].nat_ip_address
        timeout     = "5m"
    }
	
	provisioner "remote-exec" {
        inline = [
            "cloud-init status --wait"
        ]
    }
	
	provisioner "file" {
		source      = "/shared/backup"
		destination = "/home/ubuntu/backup"
  }
	provisioner "file" {
		source      = "/shared/backup-docker-compose.yml"
		destination = "/home/ubuntu/docker-compose.yml"
  }
    provisioner "remote-exec" {
    inline = [
      "cd /home/ubuntu",
      "sudo docker-compose up -d"
    ]
  }
}