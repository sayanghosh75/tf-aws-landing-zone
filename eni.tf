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

resource "aws_network_interface" "vpn-eni" {
  description       = "vpn-eni-01"
  subnet_id         = aws_subnet.public_subnet.id
  #private_ips      = []
  security_groups   = [aws_default_security_group.vpn-main-default-sec-group.id]
# Source Destination check set to false for NAT gateway
  source_dest_check = false

  tags = {
    Name = "vpn-eni-01"
  }
}
