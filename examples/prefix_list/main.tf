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
  cidr_block = var.vpc_cidr

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
  description = "Test security group for prefix list ingress"
  vpc_id      = aws_vpc.test.id

  tags = {
    Name = "${var.resource_name_prefix}-sg"
  }
}

# Create a managed prefix list for testing
resource "aws_ec2_managed_prefix_list" "test" {
  name           = "${var.resource_name_prefix}-pl"
  address_family = "IPv4"
  max_entries    = 5

  entry {
    cidr        = var.prefix_list_cidr_1
    description = "Entry 1"
  }

  entry {
    cidr        = var.prefix_list_cidr_2
    description = "Entry 2"
  }

  tags = {
    Name = "${var.resource_name_prefix}-pl"
  }
}

# HTTPS ingress rule using prefix list
module "ingress_https_prefix_list" {
  source = "../../"

  security_group_id = aws_security_group.test.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  prefix_list_id    = aws_ec2_managed_prefix_list.test.id
  description       = "Allow HTTPS from prefix list"
}
