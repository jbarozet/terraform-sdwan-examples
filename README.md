# SD-WAN Terraform Provider Examples

## Resources

Terraform Provider

- [Terraform Registry](https://registry.terraform.io/providers/CiscoDevNet/sdwan/latest)
- [Github Repository](https://github.com/CiscoDevNet/terraform-provider-sdwan)


iac-validate: Used for pre-deployment validation
- https://github.com/netascode/iac-validate

terraform-provider-sdwan: Terraform provider for SD-WAN
- https://registry.terraform.io/providers/CiscoDevNet/sdwan/latest
- https://github.com/CiscoDevNet/terraform-provider-sdwan

terraform-sdwan-nac-sdwan: Terraform modules for SD-WAN as a Code
- https://registry.terraform.io/modules/netascode/nac-sdwan/sdwan/latest
- https://github.com/netascode/terraform-sdwan-nac-sdwan

Folders:
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
