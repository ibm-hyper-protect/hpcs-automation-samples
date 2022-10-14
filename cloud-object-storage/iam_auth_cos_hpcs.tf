# Setup authorization between HPCS and COS so that
# COS bucket can be protected by HPCS root key
# "kms" holds good for HPCS too
resource "ibm_iam_authorization_policy" "auth_cos_to_hpcs" {
    source_service_name         = "cloud-object-storage"
    target_service_name         = "kms"
    source_resource_instance_id = ibm_resource_instance.cos_instance.id
    target_resource_instance_id = data.ibm_hpcs.hpcs.id
    roles                       = ["Reader"]
}
