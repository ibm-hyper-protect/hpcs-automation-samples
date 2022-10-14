# Get a reference to the HPCS instance mentioned by the user
data "ibm_hpcs" "hpcs" {
 name = var.hpcs_instance_name
}

# Create a root key on the user provided HPCS instance
resource "ibm_kms_key" "hpcs_root_key" {
  instance_id  = data.ibm_hpcs.hpcs.guid
  key_name     = var.root_key_name

  # False meaning "root key"
  standard_key = false

  # This says, the key can be deleted even if there are
  # resources associated with it. (Example : COS bucket)
  force_delete = true
}
