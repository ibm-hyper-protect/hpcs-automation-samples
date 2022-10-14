# Used to retrieve the resource ID from resource group name
data "ibm_resource_group" "resource_group" {
  name = var.hpcs_resource_group
}
