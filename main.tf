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

resource "ibm_pi_ike_policy" "rs-ike-policy" {
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_policy_name          = "ike-policy"
        pi_policy_dh_group = 20
        pi_policy_encryption = "aes-256-cbc"
        pi_policy_key_lifetime = 28800
        pi_policy_preshared_key = "sample"
        pi_policy_version = 2
        pi_policy_authentication = "sha-256"
    }

resource "ibm_pi_ipsec_policy" "rs-ipsec-policy" {
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_policy_name          = "ipsec-policy"
        pi_policy_dh_group = 20
        pi_policy_encryption = "aes-256-cbc"
        pi_policy_key_lifetime = 3600
        pi_policy_pfs = true
        pi_policy_authentication = "hmac-sha-256-128"
    }

data "ibm_pi_network" "ds-network" {
  pi_network_name = "vpn-subnet"
  pi_cloud_instance_id = local.cloud_instance_id
}

resource "ibm_pi_vpn_connection" "rs-vpn-connection" {
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_vpn_connection_name  = "vpn-connection"
        pi_ike_policy_id        = ibm_pi_ike_policy.rs-ike-policy.policy_id
        pi_ipsec_policy_id      = ibm_pi_ipsec_policy.rs-ipsec-policy.policy_id
        pi_vpn_connection_mode  = "policy"
        pi_networks             = data.ibm_pi_network.ds-network.id
        pi_peer_gateway_address = "169.46.19.234"
        pi_peer_subnets         = ["10.177.131.192/26"]
    }



