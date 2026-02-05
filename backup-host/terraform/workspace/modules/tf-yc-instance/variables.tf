# Переменные для модуля. Дублируются из variables.tf корневого модуля, только для передачи параметров, поэтому всё по минимуму.
# Валидация, описания и прочее - всё в корневом модуле.
variable "instance_name" {type = string}
variable "instance_zone" { type = string}
variable "platform_id" {type = string}
variable "scheduling_preemptible" {type = bool}
variable "disk_size" {type = number}
variable "image_id" {type = string}
variable "subnet_id" {type = string}
variable "nat" {type = bool}