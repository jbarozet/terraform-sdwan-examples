# SD-WAN Terraform Provider Examples

A couple of simple examples using the SD-WAN Terraform Provider
as well as the SD-WAN Terraform modules for even better abstraction.

## Resources

Terraform Provider

- [Terraform Registry](https://registry.terraform.io/providers/CiscoDevNet/sdwan/latest)
- [Github Repository](https://github.com/CiscoDevNet/terraform-provider-sdwan)

terraform-sdwan-nac-sdwan: Terraform modules for SD-WAN as a Code

- [Terraform Registry](https://registry.terraform.io/modules/netascode/nac-sdwan/sdwan/latest)
- [Github Repository](https://github.com/netascode/terraform-sdwan-nac-sdwan)

iac-validate: Used for pre-deployment validation

- [Github Repository](https://github.com/netascode/iac-validate)

## Folders

- `provider`: this is the code leveraging the SD-WAN Terraform provider
- `model`: this is code leveraging data models / nac-sdwan module

## Create Device Configuration

Go to `provider` or `model` folder then follow the steps:

```shell
terraform init
terraform plan
terraform apply --auto-approve
```

## Delete Configuration Group

```shell
terraform destroy --auto-approve
```

## Upgrade sdwan provider

To upgrade the latest acceptable version of each provider, use:

```shell
terraform init -upgrade
```

## Debug

You need to specify those two commands before running TF:

```shell
export TF_LOG_PATH=file.log
export TF_LOG=TRACE
```

This will save logs to file.log in the folder where you run terraform.
