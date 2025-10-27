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

output "id" {
  description = "The Terraform resource ID of the security group ingress rule."
  value       = aws_vpc_security_group_ingress_rule.this.id
}

output "security_group_rule_id" {
  description = "The AWS-assigned unique identifier for the security group rule."
  value       = aws_vpc_security_group_ingress_rule.this.security_group_rule_id
}

output "security_group_id" {
  description = "The ID of the security group to which this ingress rule is attached."
  value       = aws_vpc_security_group_ingress_rule.this.security_group_id
}

output "ingress_rule_effective_source" {
  description = "A canonical string describing the effective source for this ingress rule (CIDR, prefix list, or security group)."
  value       = local.effective_source
}

output "arn" {
  description = "The ARN of the security group rule."
  value       = aws_vpc_security_group_ingress_rule.this.arn
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags."
  value       = aws_vpc_security_group_ingress_rule.this.tags_all
}
