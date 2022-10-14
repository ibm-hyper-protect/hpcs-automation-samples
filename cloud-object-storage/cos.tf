# Creates a COS instance per Global plan
resource "ibm_resource_instance" "cos_instance" {
  name              = var.cos_instance_name
  service           = "cloud-object-storage"
  location          = "global"
  plan              = var.cos_instance_plan
  resource_group_id = data.ibm_resource_group.resource_group.id
}

# Create a COS bucket that is backed by a root key from HPCS
# Need to have S2S auth between COS and HPCS prior to this
resource "ibm_cos_bucket" "bucket" {
  depends_on           = [ibm_iam_authorization_policy.auth_cos_to_hpcs]
  resource_instance_id = ibm_resource_instance.cos_instance.id
  bucket_name          = var.cos_bucket_name
  region_location      = var.cos_bucket_region
  storage_class        = var.cos_bucket_type

  # Although it says 'key_protect', it can be HPCS too
  key_protect          = ibm_kms_key.hpcs_root_key.id
}

# Now, upload a sample file to the bucket that is created above
resource "ibm_cos_bucket_object" "bucket_object" {
  bucket_crn      = ibm_cos_bucket.bucket.crn
  bucket_location = ibm_cos_bucket.bucket.region_location
  content_file    = "demo-file.txt"
  key             = "demo-file.txt"
  etag            = filemd5("demo-file.txt")
}
