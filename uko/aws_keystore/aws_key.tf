# Create a vault on the generated UKO instance
resource ibm_hpcs_vault uko_vault {
  instance_id = ibm_hpcs.hpcs_uko.guid
  region      = ibm_hpcs.hpcs_uko.location
  name        = var.hpcs_uko_vault_name
  description = "This is the vault inside UKO that will contain KeyStores and keys"
}

# Create AWS Keystore
resource ibm_hpcs_keystore aws_keystore {
  instance_id           = ibm_hpcs_vault.uko_vault.instance_id
  region                = ibm_hpcs_vault.uko_vault.region
  uko_vault             = ibm_hpcs_vault.uko_vault.vault_id
  type                  = "aws_kms"
  vault {
    id = ibm_hpcs_vault.uko_vault.vault_id
  }
  name                  = var.aws_keystore_name
  description           = "AWS Keystore example"
  groups                = ["Demo"]

  # UKO references region as "us_east_1" for example, while
  # AWS references this as "us-east-1"
  aws_region            = replace(var.aws_region, "-", "_")
  aws_access_key_id     = var.aws_iam_access_key_id
  aws_secret_access_key = var.aws_iam_secret_access_key
}

# Create a key template that will be used to create a key under a keystore
resource ibm_hpcs_key_template key_template {
  instance_id       = ibm_hpcs_vault.uko_vault.instance_id
  region            = ibm_hpcs_vault.uko_vault.region
  uko_vault         = ibm_hpcs_vault.uko_vault.vault_id
  vault {
    id = ibm_hpcs_vault.uko_vault.vault_id
  }
  name        = var.uko_key_template_name
  description = "This template is used to create keys in a key store"
  key {
    size            = "256"
    algorithm       = "aes"
    activation_date = "P5Y1M1W2D"
    expiration_date = "P1Y2M1W4D"
    state           = "active"
  }

  # For now, let's deploy this on AWS
  keystores {
    group = "Demo"
    type  = "aws_kms"
  }
}

# Create AWS key in the keystore that is previously created
resource ibm_hpcs_managed_key aws_key {
  instance_id    = ibm_hpcs_vault.uko_vault.instance_id
  region         = ibm_hpcs_vault.uko_vault.region
  uko_vault      = ibm_hpcs_vault.uko_vault.vault_id
  vault {
    id = ibm_hpcs_vault.uko_vault.vault_id
  }
  label          = var.aws_kms_key_label
  description    = "AWS demo key from UKO"
  template_name  = ibm_hpcs_key_template.key_template.name
}
