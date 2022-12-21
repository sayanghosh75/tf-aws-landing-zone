# Copyright 2021, 2022. Kyndryl All Rights Reserved.
# #
# # Licensed under the Apache License, Version 2.0 (the "License");
# # you may not use this file except in compliance with the License.
# # You may obtain a copy of the License at
# #
# # https://www.apache.org/licenses/LICENSE-2.0
# #
# # Unless required by applicable law or agreed to in writing, software
# # distributed under the License is distributed on an "AS IS" BASIS,
# # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# # See the License for the specific language governing permissions and
# # limitations under the License.
# #

## Configure the default VPN NACL with appropriate rules
resource "aws_default_network_acl" "vpn-main-default-nacl" {
  default_network_acl_id = aws_vpc.vpn_main.default_network_acl_id
}

resource "aws_network_acl_rule" "allow_all_ingress" {
  network_acl_id = aws_default_network_acl.vpn-main-default-nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" 
#  cidr_block     = aws_vpc.vpn_main.cidr_block
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "allow_ssh" {
  network_acl_id = aws_default_network_acl.vpn-main-default-nacl.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" 
#  cidr_block     = aws_vpc.vpn_main.cidr_block
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "allow_https" {
  network_acl_id = aws_default_network_acl.vpn-main-default-nacl.id
  rule_number    = 210
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "allow_custom_openvpn" {
  network_acl_id = aws_default_network_acl.vpn-main-default-nacl.id
  rule_number    = 220
  egress         = false
  protocol       = var.iaas_aws_openvpn_protocol
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
#  cidr_block     = aws_vpc.vpn_main.cidr_block
  from_port      = var.iaas_aws_openvpn_port
  to_port        = var.iaas_aws_openvpn_port
}

resource "aws_network_acl_rule" "allow_all_egress" {
  network_acl_id = aws_default_network_acl.vpn-main-default-nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}