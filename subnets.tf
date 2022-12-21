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

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpn_main.id
  cidr_block        = var.iaas_aws_vpc_public_subnet_cidr
  availability_zone = join("",[var.iaas_aws_region,"a"])
  map_public_ip_on_launch = true

  tags = {
    Name = "vpn-main-public-1a"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpn_main.id
  cidr_block        = var.iaas_aws_vpc_private_subnet_cidr
  availability_zone = join("",[var.iaas_aws_region,"b"])
  map_public_ip_on_launch = false

  tags = {
    Name = "vpn-main-private-1b"
  }
}

resource "aws_route_table_association" "vpn_main_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_default_route_table.vpn-main-master-public.id
}

resource "aws_route_table_association" "vpn_main_private_subnet" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.vpn-main-master-private.id
}