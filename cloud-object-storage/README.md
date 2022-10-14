# Introduction

This README details how to automatically provision an instance of [IBM Cloud Object Storage - COS](https://www.ibm.com/products/cloud-object-storage) bucket that is encrypted by a root key in [Hyper Protect Crypto Services](https://cloud.ibm.com/docs/hs-crypto?topic=hs-crypto-overview) instance on IBM cloud.

### Pre-requisites
It is required that the Terraform is [installed](https://learn.hashicorp.com/tutorials/terraform/install-cli) on the machine and the PATH variable is set appropriately. Execute `terraform --help` and make sure it works per expectation.

To use Terraform,  IAM API key is needed. Login to [cloud.ibm.com](https://cloud.ibm.com) to create IAM API key. 

Goto `Manage --> Access (IAM) --> API keys --> [Create an IBM Cloud API key]`. Save the key content as it is needed to be specified while running the automation..

Also, if you prefer to clone this repository, make sure that [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) is installed on your local machine. 
If you prefer downloading these files from [here](https://github.com/ibm-hyper-protect/hpcs-automation-samples/tree/main/cloud-object-storage) then Git is not needed to be installed. `Make sure that everything in this repository is downloaded to the same directory.`

It is also required that an instance of [Hyper Protect Crypto Services - HPCS](https://cloud.ibm.com/docs/hs-crypto?topic=hs-crypto-overview) is already provisioned and Master key is initialised. Automation will then create a root key on this HPCS instance.

### Running the automation

By default, COS bucket is created in `us-east` region. However, this can be overridden by doing `export TF_VAR_<name_of_the_variable>=<value>` in the terminal before running the automation.

Example: `export TF_VAR_cos_bucket_region=us-south`

See `variables.tf` for a list of variables used and their default values. 

Below commands assume that none of the default values are overridden, and only the required values are to be entered when prompted.
If you want to provide values for the required variables beforehand, then you may set these variables prior to running the automation.

Example: `export TF_VAR_hpcs_region=us-south`

Goto the directory that has all the files and execute :
```code
terraform init
terraform apply --auto-approve
```
When `terraform apply --auto-approve` is run, you will be asked to provide input for the variables that don't have default value or they are not defined using TF_VAR_

```text
% terraform apply 
var.hpcs_instance_name
  Name of the existing HPCS instance which will be used to create a root key

  Enter a value: TEST-HPCS-TERRAFORM

var.hpcs_region
  Region that has the HPCS instance deployed

  Enter a value: us-east

var.ibm_cloud_api_key
  IAM API key that is created on IBM cloud console

  Enter a value: xxxxxxxxxxxxxxxxxxxxxx
```
After this point, automation does everything.

### Next steps
At this point, you may look at COS bucket and make sure that [demo-file.txt](https://github.com/ibm-hyper-protect/hpcs-automation-samples/blob/main/cloud-object-storage/demo-file.txt) is uploaded to the bucket. Try downloading the file and make sure that it's successful.

## Cleanup
Once you are done, you may destroy the created resources. Execute :
```
terraform destroy --auto-approve
```
When `terraform destroy --auto-approve` is run, you will be asked to provide input for the variables that don't have default value or they are not defined using TF_VAR_
```text
% terraform apply 
var.hpcs_instance_name
  Name of the existing HPCS instance which will be used to create a root key

  Enter a value: TEST-HPCS-TERRAFORM

var.hpcs_region
  Region that has the HPCS instance deployed

  Enter a value: us-east

var.ibm_cloud_api_key
  IAM API key that is created on IBM cloud console

  Enter a value: xxxxxxxxxxxxxxxxxxxxxx
```
After this point, automation cleans up everything.
 
Thank you for trying this. Please feel free to create an issue if you see a problem / submit a PR for any enhancements.
