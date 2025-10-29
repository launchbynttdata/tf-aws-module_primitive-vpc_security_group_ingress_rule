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

# Create a source security group (e.g., for application tier)
resource "aws_security_group" "source" {
  name        = "${var.resource_name_prefix}-source-sg"
  description = "Source security group (application tier)"
  vpc_id      = aws_vpc.test.id

  tags = {
    Name = "${var.resource_name_prefix}-source-sg"
  }
}

# Create a target security group (e.g., for database tier)
resource "aws_security_group" "target" {
  name        = "${var.resource_name_prefix}-target-sg"
  description = "Target security group (database tier)"
  vpc_id      = aws_vpc.test.id

  tags = {
    Name = "${var.resource_name_prefix}-target-sg"
  }
}

# Allow PostgreSQL access from source SG to target SG
module "ingress_postgres_sg" {
  source = "../../"

  security_group_id            = aws_security_group.target.id
  ip_protocol                  = "tcp"
  from_port                    = 5432
  to_port                      = 5432
  referenced_security_group_id = aws_security_group.source.id
  description                  = "Allow PostgreSQL from application tier"
}

# Allow MySQL access from source SG to target SG
module "ingress_mysql_sg" {
  source = "../../"

  security_group_id            = aws_security_group.target.id
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
  referenced_security_group_id = aws_security_group.source.id
  description                  = "Allow MySQL from application tier"
}
