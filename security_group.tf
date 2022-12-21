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

## Configure security rules in default security group
## Only inline rules can be configured

resource "aws_default_security_group" "vpn-main-default-sec-group" {
  vpc_id = aws_vpc.vpn_main.id
  
  ingress {
    description = "HTTPS from VPC"
    protocol    = "tcp"
  #  self        = true
  #  cidr_blocks = ["aws_vpc.vpn_main.cidr_block"]
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
  }

  ingress {
    description = "SSH from Global"
    protocol    = "tcp"
  #  self        = true
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

  ingress {
    description = "Custom OpenVPN from Global"
    protocol    = var.iaas_aws_openvpn_protocol
  #  self        = true
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = var.iaas_aws_openvpn_port
    to_port     = var.iaas_aws_openvpn_port
  }

  egress {
    description = "Allow all traffic"
    protocol    = "-1"
  #  self        = true
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }


  tags = {
    Name = "vpn-main-sg-01"
  }

}