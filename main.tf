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



