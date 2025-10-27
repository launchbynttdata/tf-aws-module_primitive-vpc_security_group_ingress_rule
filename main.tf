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

resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id = var.security_group_id
  ip_protocol       = var.ip_protocol
  from_port         = var.from_port
  to_port           = var.to_port

  cidr_ipv4                    = var.cidr_ipv4
  cidr_ipv6                    = var.cidr_ipv6
  prefix_list_id               = var.prefix_list_id
  referenced_security_group_id = var.referenced_security_group_id

  description = var.description
  tags        = local.tags
}
