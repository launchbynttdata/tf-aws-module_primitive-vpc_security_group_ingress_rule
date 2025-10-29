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

variable "security_group_id" {
  description = "The ID of the security group to which this ingress rule will be attached."
  type        = string

  validation {
    condition     = can(regex("^sg-[a-f0-9]+$", var.security_group_id))
    error_message = "The security_group_id must be a valid security group ID starting with 'sg-'."
  }
}

variable "ip_protocol" {
  description = "The IP protocol name or number. Use '-1' to specify all protocols. Protocol numbers: https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml"
  type        = string

  validation {
    condition     = can(regex("^(-1|[0-9]+|tcp|udp|icmp|icmpv6)$", var.ip_protocol))
    error_message = "The ip_protocol must be a valid IANA protocol name (tcp, udp, icmp, icmpv6) or number, or '-1' for all protocols."
  }
}

variable "from_port" {
  description = "The start of port range for the TCP and UDP protocols, or an ICMP type number. Required for tcp and udp protocols. Use -1 for ICMP type."
  type        = number
  default     = null
}

variable "to_port" {
  description = "The end of port range for the TCP and UDP protocols, or an ICMP code. Required for tcp and udp protocols. Use -1 for ICMP code."
  type        = number
  default     = null
}

variable "cidr_ipv4" {
  description = "The source IPv4 CIDR range for this ingress rule. Mutually exclusive with cidr_ipv6, prefix_list_id, and referenced_security_group_id."
  type        = string
  default     = null

  validation {
    condition     = var.cidr_ipv4 == null || can(cidrhost(var.cidr_ipv4, 0))
    error_message = "The cidr_ipv4 must be a valid IPv4 CIDR block."
  }
}

variable "cidr_ipv6" {
  description = "The source IPv6 CIDR range for this ingress rule. Mutually exclusive with cidr_ipv4, prefix_list_id, and referenced_security_group_id."
  type        = string
  default     = null

  validation {
    condition     = var.cidr_ipv6 == null || can(cidrhost(var.cidr_ipv6, 0))
    error_message = "The cidr_ipv6 must be a valid IPv6 CIDR block."
  }
}

variable "prefix_list_id" {
  description = "The ID of the prefix list for the source of this ingress rule. Mutually exclusive with cidr_ipv4, cidr_ipv6, and referenced_security_group_id."
  type        = string
  default     = null

  validation {
    condition     = var.prefix_list_id == null || can(regex("^pl-[a-f0-9]+$", var.prefix_list_id))
    error_message = "The prefix_list_id must be a valid prefix list ID starting with 'pl-'."
  }
}

variable "referenced_security_group_id" {
  description = "The ID of the source security group for this ingress rule. Mutually exclusive with cidr_ipv4, cidr_ipv6, and prefix_list_id."
  type        = string
  default     = null

  validation {
    condition     = var.referenced_security_group_id == null || can(regex("^sg-[a-f0-9]+$", var.referenced_security_group_id))
    error_message = "The referenced_security_group_id must be a valid security group ID starting with 'sg-'."
  }
}

variable "description" {
  description = "The description of this ingress rule."
  type        = string
  default     = null

  validation {
    condition     = var.description == null || length(var.description) <= 255
    error_message = "The description must be 255 characters or less."
  }
}

variable "tags" {
  description = "A map of tags to assign to the ingress rule."
  type        = map(string)
  default     = {}
}
