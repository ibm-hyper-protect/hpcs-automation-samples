# Configure IBM provider mapping to the region
provider "ibm" {
  region           = var.ibm_cloud_region
  ibmcloud_api_key = var.ibm_cloud_api_key
}
