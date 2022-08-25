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
#  pi_image_storage_type     = "tier3"
#}


#data "ibm_pi_image" "custom_image" {
#  pi_cloud_instance_id = local.cloud_instance_id
#  pi_image_name        = "custom-image-${local.timestamp}"
#}

resource "ibm_pi_key" "ssh_key" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_key_name          = "ssh-key-${local.timestamp}"
  pi_ssh_key           = var.ssh_key_value
}

data "ibm_pi_key" "ssh_key" {
  depends_on           = [ibm_pi_key.power_sshkey]
  pi_cloud_instance_id = local.cloud_instance_id
  pi_key_name          = "ssh-key-${local.timestamp}"
}

