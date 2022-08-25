resource "ibm_pi_image" "testacc_image  "{
  pi_image_name             = "custom-image-imported"
  pi_cloud_instance_id      = "d79a6170-22cc-47a0-bede-5f141d44f6c0"
  pi_image_bucket_name      = "pt-bucket"
  pi_image_bucket_access    = "private"
  pi_image_access_key       = "a7740bb9922f4030a4e00fecca769d20"
  pi_image_secret_key       = "0b23eac638f040ce3c3c65fea133d7ffd0ddaeeca30b0adf"
  pi_image_bucket_region    = "us-south"
  pi_image_bucket_file_name = "paytesterv1.ova.gz"
  pi_image_storage_type     = "tier1"
}