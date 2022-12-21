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

resource "aws_default_route_table" "vpn-main-master-public" {
  default_route_table_id = aws_vpc.vpn_main.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "vpn-main-master-public"
  }
}

resource "aws_route_table" "vpn-main-master-private" {
  vpc_id = aws_vpc.vpn_main.id

  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id = aws_network_interface.vpn-eni.id
    }

  tags = {
    Name = "vpn-main-master-private"
  }
}