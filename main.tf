resource "ibm_pi_ike_policy" "rs_ike_policy" {
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_policy_name          = "gtg-ike_policy10"
        pi_policy_dh_group = 20
        pi_policy_encryption = "aes-256-cbc"
        pi_policy_key_lifetime = 28800
        pi_policy_preshared_key = "falabella"
        pi_policy_version = 2
        pi_policy_authentication = "sha-256"
    }

resource "ibm_pi_ipsec_policy" "rs_ipsec_policy" {
        depends_on = [ibm_pi_ike_policy.rs_ike_policy]
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_policy_name          = "gtg-ipsec_policy10"
        pi_policy_dh_group = 20
        pi_policy_encryption = "aes-256-cbc"
        pi_policy_key_lifetime = 28800
        pi_policy_pfs = true
        pi_policy_authentication = "hmac-sha-256-128"
    }

data "ibm_pi_network" "ds_network" {
  pi_network_name = "testvpn"
  pi_cloud_instance_id = local.cloud_instance_id
    }

resource "ibm_pi_vpn_connection" "rs_vpn_connection" {
        depends_on = [ibm_pi_ike_policy.rs_ike_policy, ibm_pi_ipsec_policy.rs_ipsec_policy]
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_vpn_connection_name  = "gtg-vpn_connection10"
        pi_ike_policy_id        = ibm_pi_ike_policy.rs_ike_policy.policy_id
        pi_ipsec_policy_id      = ibm_pi_ipsec_policy.rs_ipsec_policy.policy_id
        pi_vpn_connection_mode  = "route"
        pi_networks             = [data.ibm_pi_network.ds_network.id]
        pi_peer_gateway_address = "169.46.19.234"
        pi_peer_subnets         = ["10.177.131.192/26"]
    }
