variable "instance_name" {
	default		= "phoenix_vm"
	type		= string
	description	= "Name of instance (virtual machine)"
	nullable = false
	sensitive = false
}

variable "instance_zone" {
  default     = "ru-central1-a"
  type        = string
  description = "Instance availability zone"
  validation {
    condition     = contains(toset(["ru-central1-a", "ru-central1-b", "ru-central1-c"]), var.instance_zone)
    error_message = "Select availability zone from the list: ru-central1-a, ru-central1-b, ru-central1-c."
  }
  sensitive = false
  nullable = false
}

variable "platform_id" {
	default		= "standard-v3"
	type		= string
	description	= "Processor unit type"
	validation {
		condition	= contains(toset(["standard-v1", "standard-v2", "standard-v3", "standard-v4a", "amd-v1"]), var.platform_id)
		error_message = "It must be one of theese: standard-v1, standard-v2, standard-v3, standard-v4a, amd-v1. Go google it if you dont sure"
	}
}

variable "scheduling_preemptible" {
	default		= true
	type		= bool
	description	= "Interruptible vm?"
}

variable "disk_size" {
	default 	= 30
	type		= number
	description	= "Boot disk size in GB"
	validation {
		condition     = var.disk_size >= 30 && var.disk_size <= 1024
		error_message = "Disk size must be between 30 and 1024 GB."
  }
}

variable "image_id" {
	default = "fd80qm01ah03dkqb14lc"
	type = string
	description = "ID of base image for VM. Check yacloud documentation for list"
}

variable "nat" {
	default = true
	type = bool
	description = "Is external ip needed?"
}