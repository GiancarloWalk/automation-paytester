# IBM Power Examples
This directory contains sample Terraform code to create a Power Systems Virtual Server
​
## Prerequisites
- An [IBM Cloud Account](https://cloud.ibm.com/registration)
- An IBM Cloud [IAM API key](https://cloud.ibm.com/docs/account?topic=account-userapikey)
- [Terraform](https://www.terraform.io/downloads)
​
## Setup
The following steps are for setting up the example terraform configuration locally:
 - Make a local copy of the files in this directory
 - Modify the variables in `variables.tf`
 - To use using a stock image, specified by `imagename` in `variables.tf`, you must first copy the stock image to Cloud Instance. 
 - If using a custom or imported image remove `pi_storage_type` from the `ibm_pi_instance` resource since the storage type will default to the custom image's storage type. 
 - Export the following environment variables when using Power resources:
```bash
export IBMCLOUD_IAM_API_ENDPOINT="https://iam.cloud.ibm.com"
# Replace '<region>' with your region.
export IBMCLOUD_PI_API_ENDPOINT="<region>.power-iaas.cloud.ibm.com"
```
​
## Export vs Define
For variables in the provider you can either export them as env variables, or define them in `provider.tf`, More information can be found about exporting vairables [here](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs#argument-reference)
​
```bash
provider "ibm" {
  ibmcloud_api_key      = "<key>"
  region                = "<region>"
  zone                  = "<zone>"
}
​
OR
​
provider "ibm" {}
export IC_API_KEY="<key>"
export IBMCLOUD_REGION="<region>"
export IBMCLOUD_ZONE="<zone>"
```
​
## Running the Configuration
```bash
# Initalize terraform directory and validate the configuration
terraform init
terraform fmt
terraform validate
​
# Show changes required by the current configuration
terraform plan
​
# Create or update infrastructure
terraform apply
​
# Destroy previously-created infrastructure
terraform destroy
```
​
## Documentation
 - [IBM Power Systems Virtual Server Docs](https://cloud.ibm.com/docs/power-iaas?topic=power-iaas-getting-started)
 - [Intro to Terraform](https://www.terraform.io/intro) | [Terraform Overview](https://www.terraform.io/language)
 - [Terraform SDK Docs](https://pkg.go.dev/github.com/hashicorp/terraform-plugin-sdk) (For devs contributing to repo)
​
​
## IBM Power Systems Terraform Docs
> [Link](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_capture) to IBM Terrafom Docs