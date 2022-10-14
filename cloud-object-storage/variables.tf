variable "ibm_cloud_api_key" {
  type        = string
  description = "IAM API key that is created on IBM cloud console"
}

variable "hpcs_resource_group" {
  type        = string
  default     = "default"
  description = "Resource group that contains the HPCS instance"
}

variable "hpcs_instance_name" {
  type        = string
  description = "Name of the existing HPCS instance which will be used to create a root key"
}

variable "hpcs_region" {
  type        = string
  description = "Region that has the HPCS instance deployed"
}

variable "root_key_name" {
  type = string
  default = "hpcs-demo-root-key"
  description = "Name to be given to the root key that will be created in HPCS"
}

variable "cos_bucket_name" {
  type = string
  default = "demo-cos-bucket-backed-by-hpcs"
  description = "Name of the COS bucket"
}

variable "cos_bucket_region" {
  type        = string
  default     = "us-east"
  description = "Region in which the Cloud Object Storage bucket needs to be created"
}

variable "cos_bucket_type" {
  type        = string
  default     = "smart"
  description = "Type of the COS bucket to be created"
  validation {
    condition     = ( var.cos_bucket_type == "smart"    ||
                      var.cos_bucket_type == "standard" ||
                      var.cos_bucket_type == "vault" ||
                      var.cos_bucket_type == "cold" )

    error_message = "Value of cos_bucket_type must be smart/standard/vault/cold."
  }
}

variable "cos_instance_name" {
  type = string
  default = "demo-cos-instance"
  description = "Name of the COS instance"
}

variable "cos_instance_plan" {
  type = string
  default = "standard"
  description = "Plan of the COS instance to be created"

  validation {
    condition     = ( var.cos_instance_plan == "lite"    ||
                      var.cos_instance_plan == "standard" ||
                      var.cos_instance_plan == "onerate_active" )

    error_message = "Value of cos_bucket_type must be lite/standard/onerate_active."
  }
}
