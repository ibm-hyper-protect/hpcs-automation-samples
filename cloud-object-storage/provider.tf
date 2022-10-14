# Configure the IBM Provider
provider "ibm" {
  ibmcloud_api_key = var.ibm_cloud_api_key
  region           = var.hpcs_region
}

