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

# This file is only used when Terraform is executed
# in a standalone mode. Delete this file, when calling
# this Terraform module from Ansible

iaas_aws_access_key	= "<your aws access key for programmatic access>"
iaas_aws_secret_key	= "<your aws secret key for programmatic access>"
iaas_aws_region		= "<aws region to deploy to"
iaas_aws_ssh_key	= "<ssh key name to store in the region>"
iaas_aws_security_group	= "<security group to associate with vpc"
public_key_path	= "<path and filename on local machine to ssh key"
rhel_username       = "<rhel subscription name when using RHEL Cloud Access"
rhel_password       = "<rhel subscription password when using RHEL Cloud Access"
instance_hostname   = "<EC2 instance hostname>"