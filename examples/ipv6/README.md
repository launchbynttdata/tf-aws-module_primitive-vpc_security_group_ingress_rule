# IPv6 Example

This example demonstrates IPv6 ingress rules using the `tf-aws-module_primitive-vpc_security_group_ingress_rule` module.

## Features Demonstrated

- IPv6 CIDR source
- HTTP access (port 80) from IPv6
- HTTPS access (port 443) from IPv6
- VPC with IPv6 enabled

## Usage

```bash
terraform init
terraform plan -var-file=test.tfvars
terraform apply -var-file=test.tfvars
terraform destroy -var-file=test.tfvars
```

## Resources Created

- 1 VPC (with IPv6 enabled)
- 1 Security Group
- 2 Security Group Ingress Rules (HTTP and HTTPS)

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
| <a name="module_ingress_http_ipv6"></a> [ingress\_http\_ipv6](#module\_ingress\_http\_ipv6) | ../../ | n/a |
| <a name="module_ingress_https_ipv6"></a> [ingress\_https\_ipv6](#module\_ingress\_https\_ipv6) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_security_group.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_name_prefix"></a> [resource\_name\_prefix](#input\_resource\_name\_prefix) | Prefix for resource names | `string` | `"sgir-ipv6"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_cidr_ipv6"></a> [cidr\_ipv6](#input\_cidr\_ipv6) | IPv6 CIDR block allowed for ingress | `string` | `"::/0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the test security group |
| <a name="output_ingress_rule_id"></a> [ingress\_rule\_id](#output\_ingress\_rule\_id) | ID of the HTTP IPv6 ingress rule |
| <a name="output_ingress_rule_arn"></a> [ingress\_rule\_arn](#output\_ingress\_rule\_arn) | ARN of the HTTP IPv6 ingress rule |
| <a name="output_effective_source"></a> [effective\_source](#output\_effective\_source) | Effective source for HTTP ingress rule |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the test VPC |
| <a name="output_vpc_ipv6_cidr_block"></a> [vpc\_ipv6\_cidr\_block](#output\_vpc\_ipv6\_cidr\_block) | IPv6 CIDR block of the VPC |
| <a name="output_https_ingress_rule_id"></a> [https\_ingress\_rule\_id](#output\_https\_ingress\_rule\_id) | ID of the HTTPS IPv6 ingress rule |
<!-- END_TF_DOCS -->
