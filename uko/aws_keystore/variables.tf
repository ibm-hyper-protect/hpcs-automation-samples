variable "hpcs_uko_vault_name" {
  type        = string
  default     = "hpcs-uko-demo-vault-terraform"
  description = "This is the vault inside UKO that will contain KeyStores and keys"
}

variable "hpcs_uko_instance_name" {
  type        = string
  default     = "hpcs-uko-demo-instance"
  description = "Name of the HPCS UKO instance created"
}

variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS region onto which the Keystore needs to be deployed"
}

variable "ibm_cloud_region" {
  type        = string
  default     = "us-east"
  description = "IBM region onto which the UKO instance needs to deployed"
}

variable "aws_keystore_name" {
  type        = string
  default     = "uko-aws-demo-keystore"
  description = "Name of the Keystore that is to be created in AWS"
}

variable "aws_iam_access_key_id" {
  type        = string
  description = "AWS KMS Access Key ID used for login"
}

variable "aws_iam_secret_access_key" {
  type        = string
  description = "AWS KMS Secret Access Key used for login"
}

variable "aws_kms_key_label" {
  type        = string
  default     = "uko-aws-demo-aes-key"
  description = "Name of the key alias for AES key pushed to AWS"
}

variable "uko_key_template_name" {
  type        = string
  default     = "uko-aws-demo-key-template"
  description = "Name to be given for the created key template"
}

variable "aws_s3_bucket_name" {
  type        = string
  default     = "uko-aws-demo-s3-bucket"
  description = "Name to be given for the created S3 bucket"
}
