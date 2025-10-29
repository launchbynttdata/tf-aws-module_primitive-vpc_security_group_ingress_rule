# Security Group to Security Group Example

This example demonstrates using security groups as sources for ingress rules with the `tf-aws-module_primitive-vpc_security_group_ingress_rule` module.

## Features Demonstrated

- Security group reference as source
- Database tier security (PostgreSQL and MySQL)
- Multi-tier application architecture
- Security group peering

## Usage

```bash
terraform init
terraform plan -var-file=test.tfvars
terraform apply -var-file=test.tfvars
terraform destroy -var-file=test.tfvars
```

## Resources Created

- 1 VPC
- 2 Security Groups (source and target)
- 2 Security Group Ingress Rules (PostgreSQL and MySQL)

## Architecture

This example simulates a multi-tier application:
- Source SG: Application tier
- Target SG: Database tier
- Rules: Allow database access from application tier only

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
| <a name="module_ingress_postgres_sg"></a> [ingress\_postgres\_sg](#module\_ingress\_postgres\_sg) | ../../ | n/a |
| <a name="module_ingress_mysql_sg"></a> [ingress\_mysql\_sg](#module\_ingress\_mysql\_sg) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_security_group.source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_name_prefix"></a> [resource\_name\_prefix](#input\_resource\_name\_prefix) | Prefix for resource names | `string` | `"sgir-sg-to-sg"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the target security group |
| <a name="output_ingress_rule_id"></a> [ingress\_rule\_id](#output\_ingress\_rule\_id) | ID of the PostgreSQL ingress rule |
| <a name="output_ingress_rule_arn"></a> [ingress\_rule\_arn](#output\_ingress\_rule\_arn) | ARN of the PostgreSQL ingress rule |
| <a name="output_effective_source"></a> [effective\_source](#output\_effective\_source) | Effective source for PostgreSQL ingress rule |
| <a name="output_source_security_group_id"></a> [source\_security\_group\_id](#output\_source\_security\_group\_id) | ID of the source security group |
| <a name="output_mysql_ingress_rule_id"></a> [mysql\_ingress\_rule\_id](#output\_mysql\_ingress\_rule\_id) | ID of the MySQL ingress rule |
<!-- END_TF_DOCS -->
