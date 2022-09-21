# Introduction

This README details how to use the automation that does below operations when run.
- Provision [Hyper Protect Crypto Services with Unified Key Orchestrator](https://cloud.ibm.com/docs/hs-crypto?topic=hs-crypto-uko-overview) on IBM cloud.
- Create a vault
- Create AWS keystore inside the vault
- Create AES key in AWS keystore
- Create S3 bucket on AWS which is encrypted by the key just created
- Upload a demo file onto the AWS S3 bucket

### Pre-requisites
It is required that the Terraform is [installed](https://learn.hashicorp.com/tutorials/terraform/install-cli) on the machine and the PATH variable is set appropriately. Execute `terraform --help` and make sure it works per expectation.

To create UKO instance,  IAM API key is needed. Login to [cloud.ibm.com](https://cloud.ibm.com) to create IAM API key. 

Goto `Manage --> Access (IAM) --> API keys --> [Create an IBM Cloud API key]`. Save the key content as it is needed to be specified while running the automation..

To connect to AWS, `access key id` and `secret access key` are needed. Follow [this document](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html) that explains how to generate them from AWS IAM console. Save these as it is needed to be specified while running the automation..

Also, if you prefer to clone this repository, make sure that [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) is installed on your local machine. 
If you prefer downloading these files from [here](https://github.com/ibm-hyper-protect/hpcs-automation-samples/tree/main/uko/aws_keystore) then Git is not needed to be installed. `Make sure that everything in this repository is downloaded to the same directory.`

### Running the automation

By default, UKO is created in `us-east` region, and AWS key is created in `us-east-1` region. However, all this can be overridden by doing `export TF_VAR_<name_of_the_variable>=<value>` in the terminal before running the automation.

Example: `export TF_VAR_aws_region=us-south-1`

See `variables.tf` for a list of variables used and their default values. 

Below snippet assumes that none of the default values are overridden, and only the required values are to be entered when prompted.

Goto the directory that has all the files and execute :
```code
terraform init
terraform apply --auto-approve
```
When `terraform apply --auto-approve` is run, you will be asked to provide input for the variables that don't have default value.
```text
% terraform apply 
var.aws_iam_access_key_id
  AWS KMS Access Key ID used for login

  Enter a value: xxxxxxxxxxxxx

var.aws_iam_secret_access_key
  AWS KMS Secret Access Key used for login

  Enter a value: xxxxxxxxxxxxxxxxxxxxxx

var.ibm_cloud_api_key
  IAM API key that is created on IBM cloud console

  Enter a value: xxxxxxxxxxxxxxxxxxxxxxxx
```
After this point, automation does everything.

### Next steps
At this point, you may login to AWS and see the S3 bucket, and download the object inside the bucket.

- **List AWS S3 buckets**
![](https://github.com/ibm-hyper-protect/hpcs-automation-samples/blob/main/uko/aws_keystore/images/AWS%20list%20S3%20buckets.png)



- **Click the bucket name to see the object name**
![](https://github.com/ibm-hyper-protect/hpcs-automation-samples/blob/main/uko/aws_keystore/images/AWS%20inside%20the%20S3%20bucket.png)



- **Click the object name and select `Download`**
![](https://github.com/ibm-hyper-protect/hpcs-automation-samples/blob/main/uko/aws_keystore/images/AWS%20S3%20bucket%20object.png)


The downloaded object should show:
***
**Welcome,**

**This file is residing in AWS S3 bucket, which is encrypted by a root key that is 
managed by Unified Key Orchestrator in IBM Cloud.**
***

 Now, you may go back to the UKO instance in [cloud.ibm.com](https://cloud.ibm.com) and `Deactivate` the key that was created and try downloading the object again from S3 bucket.

- Login to [cloud.ibm.com](https://cloud.ibm.com) and click **&#9776; Resource list** at the top left corner, and click on `Services and Software` and
  click on the UKO instance.

- **Deactivate the key as shown below:**
![](https://github.com/ibm-hyper-protect/hpcs-automation-samples/blob/main/uko/aws_keystore/images/HPCS%20UKO%20-%20Deactivate%20the%20key.png)



![](https://github.com/ibm-hyper-protect/hpcs-automation-samples/blob/main/uko/aws_keystore/images/HPCS%20UKO%20-%20Deactivate%20key%20-%20confirmation.png)



![](https://github.com/ibm-hyper-protect/hpcs-automation-samples/blob/main/uko/aws_keystore/images/HPCS%20UKO%20-%20AWS%20Key%20Deactivated.png)



- **List AWS S3 buckets**
![](https://github.com/ibm-hyper-protect/hpcs-automation-samples/blob/main/uko/aws_keystore/images/AWS%20list%20S3%20buckets.png)



- **Click the bucket name to see the object name**
![](https://github.com/ibm-hyper-protect/hpcs-automation-samples/blob/main/uko/aws_keystore/images/AWS%20inside%20the%20S3%20bucket.png)



- **Click the object name and select `Download`**
![](https://github.com/ibm-hyper-protect/hpcs-automation-samples/blob/main/uko/aws_keystore/images/AWS%20S3%20bucket%20object.png)



Download should fail and browser should display an error message

Example:
***
KMS.KMSInvalidStateExceptionarn:aws:kms:us-east-2:562583747290:key/6bbdbd5c-a825-4d95-a64e-3eb7650e1055 is pending import.TRF0KDXAG9VJDZ08Tq7dlx6OWrAHd96UIm4s9oWuzUySrj/l/f+aQvLwHPk0drtrk1Bu/Qyy0rsC4n7UXXXb3EHZ8CI=
***

Now go back to UKO instance, `Activate` the key, and try to download the file again.

Once you are done, you may destroy the created resources. Execute :
```
terraform destroy --auto-approve
```
When `terraform destroy --auto-approve` is run, you will be asked to provide input for the variables that don't have default value.
```text
% terraform apply 
var.aws_iam_access_key_id
  AWS KMS Access Key ID used for login

  Enter a value: xxxxxxxxxxxxx

var.aws_iam_secret_access_key
  AWS KMS Secret Access Key used for login

  Enter a value: xxxxxxxxxxxxxxxxxxxxxx

var.ibm_cloud_api_key
  IAM API key that is created on IBM cloud console

  Enter a value: xxxxxxxxxxxxxxxxxxxxxxxx
```
After this point, automation cleans up everything.
 
Thank you for trying this. Please feel free to create an issue if you see a problem / submit a PR for any enhancements.
