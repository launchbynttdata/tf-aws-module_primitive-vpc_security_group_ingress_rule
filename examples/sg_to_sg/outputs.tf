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

output "security_group_id" {
  description = "ID of the target security group"
  value       = aws_security_group.target.id
}

output "ingress_rule_id" {
  description = "ID of the PostgreSQL ingress rule"
  value       = module.ingress_postgres_sg.id
}

output "ingress_rule_arn" {
  description = "ARN of the PostgreSQL ingress rule"
  value       = module.ingress_postgres_sg.arn
}

output "effective_source" {
  description = "Effective source for PostgreSQL ingress rule"
  value       = module.ingress_postgres_sg.ingress_rule_effective_source
}

# Additional outputs
output "source_security_group_id" {
  description = "ID of the source security group"
  value       = aws_security_group.source.id
}

output "mysql_ingress_rule_id" {
  description = "ID of the MySQL ingress rule"
  value       = module.ingress_mysql_sg.id
}
