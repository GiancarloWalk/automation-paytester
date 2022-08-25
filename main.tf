locals {
timestamp = formatdate("YYYYMMDDhhmmss", timestamp())
}

#resource "ibm_pi_image" "custom-image" {
#  pi_cloud_instance_id      = local.cloud_instance_id
#  pi_image_name             = "custom-image-${local.timestamp}"
#  pi_image_bucket_name      = "pt-bucket"
#  pi_image_bucket_access    = "private"
#  pi_image_access_key       = "a7740bb9922f4030a4e00fecca769d20"
#  pi_image_secret_key       = "0b23eac638f040ce3c3c65fea133d7ffd0ddaeeca30b0adf"
#  pi_image_bucket_region    = "us-south"
#  pi_image_bucket_file_name = "paytesterv1.ova.gz"
#  pi_image_storage_type     = "tier1"
#  timeouts {
#   create = "2h"
#   delete = "2h"
#  }
#}

#data "ibm_pi_image" "custom_image" {
#  depends_on           = [ibm_pi_image.custom-image]
#  pi_cloud_instance_id = local.cloud_instance_id
#  pi_image_name        = "custom-image-${local.timestamp}"
#}

data "ibm_pi_image" "custom_image" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_image_name        = "paytester-custom"
}

resource "ibm_pi_key" "ssh_key" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_key_name          = "ssh-key-${local.timestamp}"
  pi_ssh_key           = var.ssh_key_value
}

data "ibm_pi_key" "ssh_key" {
  depends_on           = [ibm_pi_key.ssh_key]
  pi_cloud_instance_id = local.cloud_instance_id
  pi_key_name          = "ssh-key-${local.timestamp}"
}

resource "ibm_pi_network" "power_pub_network" {
  count                = 1
  pi_network_name      = "pub-network-${local.timestamp}"  
  pi_cloud_instance_id = local.cloud_instance_id
  pi_network_type      = "pub-vlan"
  pi_dns               = ["9.9.9.9"]
}

data "ibm_pi_network" "power_pub_network" {
  depends_on           = [ibm_pi_network.power_pub_network]
  pi_cloud_instance_id = local.cloud_instance_id
  pi_network_name      = "pub-network-${local.timestamp}"
}  


resource "ibm_pi_network" "power_priv_network" {
  count                = 1
  pi_network_name      = "priv-network-${local.timestamp}"  
  pi_cloud_instance_id = local.cloud_instance_id
  pi_network_type      = "vlan"
  pi_dns               = ["127.0.0.1"]
  pi_cidr              = "192.168.0.0/24"
  pi_gateway           = "192.168.0.1"
  pi_ipaddress_range {
    pi_starting_ip_address  = "192.168.0.2"
    pi_ending_ip_address    = "192.168.0.254"
  }
}

data "ibm_pi_network" "priv-network" {
  depends_on           = [ibm_pi_network.power_priv_network]
  pi_cloud_instance_id = local.cloud_instance_id
  pi_network_name      = "priv-network-${local.timestamp}"
}

resource "ibm_pi_instance" "instance" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_memory            = var.memory
  pi_processors        = var.processors
  pi_instance_name     = "lpar-${local.timestamp}"
  pi_proc_type         = var.processor_type
  pi_image_id          = data.ibm_pi_image.custom_image.id
  pi_key_pair_name     = data.ibm_pi_key.ssh_key.id
  pi_sys_type          = var.sys_type
  pi_storage_type      = var.storage_type
  pi_network {
    network_id = data.ibm_pi_network.pub-network.id  
  }
}