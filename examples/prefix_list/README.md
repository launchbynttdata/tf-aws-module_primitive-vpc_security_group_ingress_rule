# Prefix List Example

This example demonstrates using a managed prefix list as the source for an ingress rule with the `tf-aws-module_primitive-vpc_security_group_ingress_rule` module.

## Features Demonstrated

- Managed prefix list source
- HTTPS access (port 443) from prefix list
- Multiple CIDR blocks in a single prefix list

## Usage

```bash
terraform init
terraform plan -var-file=test.tfvars
terraform apply -var-file=test.tfvars
terraform destroy -var-file=test.tfvars
```

## Resources Created

- 1 VPC
- 1 Security Group
- 1 Managed Prefix List (with 2 entries)
- 1 Security Group Ingress Rule

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.100 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ingress_https_prefix_list"></a> [ingress\_https\_prefix\_list](#module\_ingress\_https\_prefix\_list) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_ec2_managed_prefix_list.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_security_group.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_name_prefix"></a> [resource\_name\_prefix](#input\_resource\_name\_prefix) | Prefix for resource names | `string` | `"sgir-prefix-list"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_prefix_list_cidr_1"></a> [prefix\_list\_cidr\_1](#input\_prefix\_list\_cidr\_1) | First CIDR for prefix list | `string` | `"10.1.0.0/24"` | no |
| <a name="input_prefix_list_cidr_2"></a> [prefix\_list\_cidr\_2](#input\_prefix\_list\_cidr\_2) | Second CIDR for prefix list | `string` | `"10.2.0.0/24"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the test security group |
| <a name="output_ingress_rule_id"></a> [ingress\_rule\_id](#output\_ingress\_rule\_id) | ID of the HTTPS ingress rule |
| <a name="output_ingress_rule_arn"></a> [ingress\_rule\_arn](#output\_ingress\_rule\_arn) | ARN of the HTTPS ingress rule |
| <a name="output_effective_source"></a> [effective\_source](#output\_effective\_source) | Effective source for the ingress rule |
| <a name="output_prefix_list_id"></a> [prefix\_list\_id](#output\_prefix\_list\_id) | ID of the managed prefix list |
<!-- END_TF_DOCS -->
