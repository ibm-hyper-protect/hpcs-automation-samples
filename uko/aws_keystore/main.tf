terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.44.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.31.0"
    }
  }
}
