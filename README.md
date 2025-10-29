# tf-aws-module_primitive-vpc_security_group_ingress_rule

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This Terraform primitive module manages a single AWS VPC security group ingress rule using the `aws_vpc_security_group_ingress_rule` resource from the AWS provider (v5.100+).

The module exposes all major functionality of the native resource with sensible defaults and lightweight validation, allowing the AWS provider to handle complex validation logic.

## Features

- **Complete Resource Coverage**: Exposes all major arguments of `aws_vpc_security_group_ingress_rule`
- **Multiple Source Types**: Supports IPv4 CIDR, IPv6 CIDR, prefix lists, and security group references
- **Protocol Flexibility**: Works with TCP, UDP, ICMP, ICMPv6, and all protocols (`-1`)
- **Lightweight Validation**: Basic input validation with provider-delegated complex rules
- **Idempotent**: Safe updates when fields change

## Usage

### Basic Example - IPv4 CIDR

```hcl
module "ssh_ingress" {
  source = "github.com/launchbynttdata/tf-aws-module_primitive-vpc_security_group_ingress_rule"

  security_group_id = aws_security_group.example.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "10.0.1.0/24"
  description       = "Allow SSH from internal network"
}
```

### IPv6 Example

```hcl
module "https_ingress_ipv6" {
  source = "github.com/launchbynttdata/tf-aws-module_primitive-vpc_security_group_ingress_rule"

  security_group_id = aws_security_group.example.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv6         = "::/0"
  description       = "Allow HTTPS from anywhere (IPv6)"
}
```

### Security Group to Security Group

```hcl
module "database_ingress" {
  source = "github.com/launchbynttdata/tf-aws-module_primitive-vpc_security_group_ingress_rule"

  security_group_id            = aws_security_group.database.id
  ip_protocol                  = "tcp"
  from_port                    = 5432
  to_port                      = 5432
  referenced_security_group_id = aws_security_group.application.id
  description                  = "Allow PostgreSQL from application tier"
}
```

### Prefix List Example

```hcl
module "https_ingress_prefix_list" {
  source = "github.com/launchbynttdata/tf-aws-module_primitive-vpc_security_group_ingress_rule"

  security_group_id = aws_security_group.example.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  prefix_list_id    = aws_ec2_managed_prefix_list.example.id
  description       = "Allow HTTPS from managed prefix list"
}
```

## Examples

The `examples/` directory contains several working examples:

- **[complete](./examples/complete/)** - Multiple ingress rules with different configurations
- **[minimal](./examples/minimal/)** - Minimal configuration with a single SSH rule
- **[ipv6](./examples/ipv6/)** - IPv6 CIDR source examples
- **[prefix_list](./examples/prefix_list/)** - Using managed prefix lists as sources
- **[sg_to_sg](./examples/sg_to_sg/)** - Security group to security group peering

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 5.100 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.100 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| security_group_id | The ID of the security group to which this ingress rule will be attached | `string` | n/a | yes |
| ip_protocol | The IP protocol name or number. Use '-1' to specify all protocols | `string` | n/a | yes |
| from_port | The start of port range for TCP/UDP, or ICMP type number | `number` | `null` | no |
| to_port | The end of port range for TCP/UDP, or ICMP code | `number` | `null` | no |
| cidr_ipv4 | The source IPv4 CIDR range | `string` | `null` | no |
| cidr_ipv6 | The source IPv6 CIDR range | `string` | `null` | no |
| prefix_list_id | The ID of the prefix list for the source | `string` | `null` | no |
| referenced_security_group_id | The ID of the source security group | `string` | `null` | no |
| description | The description of this ingress rule | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID of the security group ingress rule |
| security_group_rule_id | The AWS-assigned unique identifier for the security group rule |
| security_group_id | The ID of the security group to which this ingress rule is attached |
| ingress_rule_effective_source | A canonical string describing the effective source (CIDR, prefix list, or security group) |
| arn | The ARN of the security group rule |
| tags_all | A map of tags assigned to the resource |

## Behavior & Limitations

### Source Mutual Exclusivity

**Exactly one** source parameter must be specified:
- `cidr_ipv4`
- `cidr_ipv6`
- `prefix_list_id`
- `referenced_security_group_id`

The module will fail validation if none or multiple sources are provided.

### Port Requirements

For TCP and UDP protocols:
- Both `from_port` and `to_port` are **required**
- `from_port` must be ≤ `to_port`
- Valid range: 0-65535

For protocol `-1` (all):
- Ports should be `null` or omitted

For ICMP/ICMPv6:
- `from_port` = ICMP type
- `to_port` = ICMP code
- Use `-1` for any type/code

### Protocol Values

- Named protocols: `tcp`, `udp`, `icmp`, `icmpv6`
- Protocol numbers: `6` (TCP), `17` (UDP), etc.
- All protocols: `-1`

See [IANA Protocol Numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml) for reference.

## Development

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) ~> 1.0
- [Go](https://golang.org/doc/install) ~> 1.24 (for testing)
- [pre-commit](https://pre-commit.com/) (installed via framework)
- AWS credentials configured

### Setup

```bash
# Bootstrap development environment
make configure

# Install pre-commit hooks
pre-commit install
```

### Testing

```bash
# Run all checks (fmt, validate, lint, unit tests)
make check

# Run integration tests for an example
cd examples/complete
terraform init
terraform plan -var-file=test.tfvars
terraform apply -var-file=test.tfvars
terraform destroy -var-file=test.tfvars
```

### Pre-commit Hooks

The framework includes pre-commit hooks for:
- Terraform formatting
- Terraform validation
- TFLint
- Documentation generation
- Security scanning

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## License

This module is licensed under the Apache License 2.0. See [LICENSE](./LICENSE) for details.

## Authors

Maintained by [Launch by NTT DATA](https://github.com/launchbynttdata).

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The ID of the security group to which this ingress rule will be attached. | `string` | n/a | yes |
| <a name="input_ip_protocol"></a> [ip\_protocol](#input\_ip\_protocol) | The IP protocol name or number. Use '-1' to specify all protocols. Protocol numbers: https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml | `string` | n/a | yes |
| <a name="input_from_port"></a> [from\_port](#input\_from\_port) | The start of port range for the TCP and UDP protocols, or an ICMP type number. Required for tcp and udp protocols. Use -1 for ICMP type. | `number` | `null` | no |
| <a name="input_to_port"></a> [to\_port](#input\_to\_port) | The end of port range for the TCP and UDP protocols, or an ICMP code. Required for tcp and udp protocols. Use -1 for ICMP code. | `number` | `null` | no |
| <a name="input_cidr_ipv4"></a> [cidr\_ipv4](#input\_cidr\_ipv4) | The source IPv4 CIDR range for this ingress rule. Mutually exclusive with cidr\_ipv6, prefix\_list\_id, and referenced\_security\_group\_id. | `string` | `null` | no |
| <a name="input_cidr_ipv6"></a> [cidr\_ipv6](#input\_cidr\_ipv6) | The source IPv6 CIDR range for this ingress rule. Mutually exclusive with cidr\_ipv4, prefix\_list\_id, and referenced\_security\_group\_id. | `string` | `null` | no |
| <a name="input_prefix_list_id"></a> [prefix\_list\_id](#input\_prefix\_list\_id) | The ID of the prefix list for the source of this ingress rule. Mutually exclusive with cidr\_ipv4, cidr\_ipv6, and referenced\_security\_group\_id. | `string` | `null` | no |
| <a name="input_referenced_security_group_id"></a> [referenced\_security\_group\_id](#input\_referenced\_security\_group\_id) | The ID of the source security group for this ingress rule. Mutually exclusive with cidr\_ipv4, cidr\_ipv6, and prefix\_list\_id. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of this ingress rule. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the ingress rule. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Terraform resource ID of the security group ingress rule. |
| <a name="output_security_group_rule_id"></a> [security\_group\_rule\_id](#output\_security\_group\_rule\_id) | The AWS-assigned unique identifier for the security group rule. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group to which this ingress rule is attached. |
| <a name="output_ingress_rule_effective_source"></a> [ingress\_rule\_effective\_source](#output\_ingress\_rule\_effective\_source) | A canonical string describing the effective source for this ingress rule (CIDR, prefix list, or security group). |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the security group rule. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags. |
<!-- END_TF_DOCS -->
