terraform {
    required_version = ">=1.0.0, <2.0"
    required_providers {
        ibm = {
            source  = "IBM-Cloud/ibm"
            version = ">= 1.44.0"
        }
    }
}

locals {
  pvs_info          = split(":", var.crn)
  location          = local.pvs_info[5]
  region            = can(regex("-", local.location)) ? (can(regex("-[0-9]+$", local.location)) ? replace(local.location, regex("-[0-9]+$", local.location), "") : local.location) : (can(regex("[0-9]+$", local.location)) ? replace(local.location, regex("[0-9]+$", local.location), "") : local.location)
  cloud_instance_id = local.pvs_info[7]
  timestamp         = formatdate("YYYYMMDDhhmmss", timestamp())
}

provider "ibm" {
  ibmcloud_api_key = var.api_key
  region           = local.region
  zone             = local.location
}