# Terraform-Ansible-01

## This repor is setup Ansilbe LAB env in Azure cloud

## This code needs 2 files

## terraform.tfvars
>
>"az_subscription_id = "YOUR_az_subscription_id"
>"az_tenant_id = "YOUR_az_tenant_id""
>"az_client_id = "YOUR_az_client_id""
>"az_client_secret = "YOUR_az_client_secret""


## variable.tf
>
>"
variable "az_subscription_id" {
  default = "efc00bcc-e0fc-479b-8dc6-a1596352de54"
}
variable "az_tenant_id" {
  default = "bc11d879-f8ed-434b-bdb9-f6152e1caf6f"
}
variable "az_client_id" {
  default = "2cd39f1b-a4b7-4d1c-b80c-f48f5038570d"
}
variable "az_client_secret" {
  default = "Q7I8Q~fEwzicSNBV5_mDrAFNgzKskYUPhdy4Aaj."
}
"
