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

#Variables supplied by terraform.tfvars or ansible
variable "iaas_aws_access_key" {}
variable "iaas_aws_secret_key" {}
variable "iaas_aws_ssh_key" {}
variable "iaas_aws_region" {
  default = "ap-southeast-1"
}
variable "iaas_aws_security_group" {}
variable "public_key_path"{}
variable "rhel_username"{}
variable "rhel_password"{}
variable "instance_hostname"{}
variable "iaas_aws_vpc_cidr"{}
variable "iaas_aws_vpc_public_subnet_cidr"{}
variable "iaas_aws_vpc_private_subnet_cidr"{}
variable "iaas_aws_openvpn_port"{}
variable "iaas_aws_openvpn_protocol"{}


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider aws {
  access_key = var.iaas_aws_access_key
  secret_key = var.iaas_aws_secret_key
  region     = var.iaas_aws_region
  }