# Terraform Module for creating an Azure OpenAI resource

This module creates an Azure OpenAI resource with optional private endpoint configuration.

For more information, please refer to the [user guide](https://git.bnc.ca/iac/terraform-azure-openai/-/blob/main/README.md) and [examples](https://git.bnc.ca/iac/terraform-azure-openai/-/tree/main/examples).

## Prerequisites

- Terraform >= v1.2.0
- Need to have a resource group allocated to you in Azure
- Need to have credentials for your Azure resource group.
- Need to have a storage account to store the terraform backend.

## Providers

| Name | Version |
|------|---------|
| azurerm | >=3 |

## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | The resource group where to deploy the resource. | `string` | n/a | yes |
| local_auth_enabled | Whether to enable local authentication (api key) or not. When `local_auth_enabled` is 'false', resource uses RBAC for authentication & authorization, otherwise, it uses a key. | `bool` | `false` | no |
| location | The Azure region where to deploy the resource. | `string` | `""` | no |
| name | Name of the OpenAI resource. Leave empty if you want auto-generation. | `string` | `""` | no |
| pep_vnet_name | The name of the virtual network where to deploy a private endpoint. Leave empty, unless you want to override the virtual network. | `string` | `""` | no |
| pep_vnet_resource_group_name | The name of the virtual network's resource group where to deploy a private endpoint. Leave empty, unless you want to override the resource group. | `string` | `""` | no |
| public_access_enabled | Whether the OpenAI endpoint can be accessed from Internet or not. When `public_access_enabled` is true the endpoint is public, and can be accessed from Internet. Otherwise, the endpoint can only be accessed from within the internal network via private endpoint. | `bool` | `false` | no |
| tags | Your resource tags, if have my. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|

## Tests

```bash
cd examples/simple-example
terraform init -reconfigure -upgrade -backend-config=configs/non_production/development/dev/backend.tf
terraform apply -var-file=configs/non_production/development/dev/input.tfvars
terraform output -json >../../tests/files/terraform-outputs.json
inspec exec tests --no-create-lockfile -t azure:// --chef-license-accept-silent
terraform destroy -no-color -auto-approve -var-file=configs/non_production/development/dev/input.tfvars
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning.

## Authors

* Azure Platform Team

See also the list of [contributors](https://git.bnc.ca/iac/terraform-azure-openai/-/graphs/main) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
