// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

locals {
  # Count how many source parameters are set
  source_count = sum([
    var.cidr_ipv4 != null ? 1 : 0,
    var.cidr_ipv6 != null ? 1 : 0,
    var.prefix_list_id != null ? 1 : 0,
    var.referenced_security_group_id != null ? 1 : 0,
  ])

  # Determine if protocol requires ports
  protocol_requires_ports = contains(["tcp", "udp", "6", "17"], lower(var.ip_protocol))

  # Validation: Check that exactly one source is specified
  validate_source_count = local.source_count == 1

  # Validation: Check that TCP/UDP have required ports
  validate_ports_for_protocol = !local.protocol_requires_ports || (var.from_port != null && var.to_port != null)

  # Determine effective source for output
  effective_source = (
    var.cidr_ipv4 != null ? "cidr_ipv4:${var.cidr_ipv4}" :
    var.cidr_ipv6 != null ? "cidr_ipv6:${var.cidr_ipv6}" :
    var.prefix_list_id != null ? "prefix_list:${var.prefix_list_id}" :
    var.referenced_security_group_id != null ? "security_group:${var.referenced_security_group_id}" :
    "none"
  )

  default_tags = {
    provisioner = "Terraform"
  }

  tags = merge(local.default_tags, var.tags)
}

# Validation checks using checks block (Terraform 1.5+)
check "source_validation" {
  assert {
    condition     = local.validate_source_count
    error_message = "Exactly one source must be specified: cidr_ipv4, cidr_ipv6, prefix_list_id, or referenced_security_group_id."
  }
}

check "ports_validation" {
  assert {
    condition     = local.validate_ports_for_protocol
    error_message = "The from_port and to_port must be specified for TCP and UDP protocols."
  }
}
