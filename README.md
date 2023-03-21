# Terraform Sample

This repository contains a basic sample on how I use Terraform to provision resources in Azure (a Function App in this case).  

It is intended for use with Terraform Cloud but if you want to use Terraform's *local* backend you'll need to comment this line in the `versions.tf` file:
```hcl
terraform {
  required_providers {
    # ...
  }

  cloud {} # Comment this line to use local backend
}
```
To use Terraform Cloud you need to follow a few more steps as detailed below.

## Running this using Terraform Cloud

### Create a workspace and connect it to your Azure subscription
To get started you must have the following:
- Terraform CLI installed on your machine
- An Azure subscription
- A Terraform Cloud account, an organization and a workspace

You can get all of the above for free, here are some links for [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli), [Azure](https://azure.microsoft.com/en-us/free/) and [Terraform Cloud](https://learn.hashicorp.com/collections/terraform/cloud-get-started).

Then you need to create a service principal in your Azure tenant with a client secret and set the `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_TENANT_ID` and `ARM_SUBSCRIPTION_ID` environment variables in your Terraform Cloud workspace.  
This is detailed [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret) in the Terraform documentation.

### Set variables in your workspace
In addition to environment variables, you'll need two Terraform variables in your workspace as they are used in the `tf` files:
- The `project` variable is used in the name of the Azure resources, choose something that will make them unique
- The `location` variable contains the name of the Azure region you want to use, in `az cli` style such as `eastus`, `westus`, `westeurope`, etc.

### Set environment variables for Terraform Cloud
To establish the link between the cloned repo and the Terraform Cloud workspace, you need to set 2 environment variables. This can be done by creating a `.env` like this:
```shell
export TF_CLOUD_ORGANIZATION="<YOUR ORGANIZATION NAME>"
export TF_WORKSPACE="<YOUR WORKSPACE NAME>"
```
And running `source .env` from your terminal.  
This file is git-ignored as it contains the name of the Terraform Cloud organization and workspace. Even if those are not secrets, I consider as good practice not to commit environment-related values like this in public repositories.

### Use Terraform CLI to manage your resources
If you're still here, you should be able to authenticate (if not already done) with `terraform login` and initialize Terraform CLI with `terraform init`, all from the root of the repo from your terminal of choice.  
Then you can to use Terraform commands still from your terminal, except that everything will run in Terraform Cloud.

Enjoy !
