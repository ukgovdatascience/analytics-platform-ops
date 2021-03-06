variable "env" {}

variable "cluster_name" {}
variable "vpc_id" {}
variable "node_security_group_id" {}

variable "subnet_ids" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

variable "performance_mode" {
  default = "generalPurpose"
}

variable "throughput_mode" {
  default = "bursting"
}

# applies when throughput_mode = "provisioned"
variable "provisioned_throughput_in_mibps" {
  default = "0"
}

output "efs_dns_name" {
  value = "${aws_efs_mount_target.storage.0.dns_name}"
}

output "num_subnets" {
  value = "${length(var.subnet_ids)}"
}
