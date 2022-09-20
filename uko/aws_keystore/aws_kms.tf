# Extract the details of the key that was deployed onto AWS kms.
# When UKO deploys the key, it creates an alias and hence this
# provider gives the data needed
data aws_kms_key aws_key_from_uko {
  # Need to wait until the key is deployed
  depends_on = [ibm_hpcs_managed_key.aws_key]
  key_id = format("%s/%s", "alias", var.aws_kms_key_label)
}
