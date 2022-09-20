# This code below creates a HPCS UKO instance and also does
# the master key ceremony automatically.
# At the end of this, the UKO is available for business.
# Prior to this, we should have created the admin key
# and admin password using TKE plugin `ibmcloud tke sigkey-add`
# For simplicity, this repo has Admin keys checked in
resource ibm_hpcs hpcs_uko {
  location             = var.ibm_cloud_region
  name                 = var.hpcs_uko_instance_name

  # Using the `hpcs-hourly-uko` plan for UKO.
  # The other available plan is "standard"
  plan                 = "hpcs-hourly-uko"

  # Number of crypto units
  units                = 2

  # Number of Admin signature keys needed
  signature_threshold  = 1
  revocation_threshold = 1

  # Number of failover crypto units required
  failover_units       = 0
  service_endpoints    = "public-and-private"

  # This section below points to the admin signature key that is generated
  # by executing `ibmcloud tke sigkey-add`. Terraform uses this key when it
  # does the TKE master key ceremony to initialize the instance.
  admins {
    name  = "Admin"
    # 1.sigkey will be in tke_files directory. This code assumes that tke_files
    # is present in the same directory as this terraform file.
    # If not, put the complete path to the file
    key   = "./tke_files/1.sigkey"
    token = "passw0rd"
  }

  # Optional..
  timeouts {
    create = "55m"
    delete = "55m"
  }
}
