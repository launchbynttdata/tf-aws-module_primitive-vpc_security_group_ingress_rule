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

# Create a VPC for testing
resource "aws_vpc" "test" {
  cidr_block                       = var.vpc_cidr
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = {
    Name = "${var.resource_name_prefix}-vpc"
  }
}

# Configure the default security group to deny all traffic
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.test.id

  # No ingress or egress rules = deny all traffic
  tags = {
    Name = "${var.resource_name_prefix}-default-sg"
  }
}

# Create a security group for testing
resource "aws_security_group" "test" {
  name        = "${var.resource_name_prefix}-sg"
  description = "Test security group for IPv6 ingress"
  vpc_id      = aws_vpc.test.id

  tags = {
    Name = "${var.resource_name_prefix}-sg"
  }
}

# IPv6 HTTP ingress rule
module "ingress_http_ipv6" {
  source = "../../"

  security_group_id = aws_security_group.test.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv6         = var.cidr_ipv6
  description       = "Allow HTTP from IPv6 CIDR"
}

# IPv6 HTTPS ingress rule
module "ingress_https_ipv6" {
  source = "../../"

  security_group_id = aws_security_group.test.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv6         = var.cidr_ipv6
  description       = "Allow HTTPS from IPv6 CIDR"
}
