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

#Define the compute instance to be provisioned

resource "aws_instance" "vpn-gateway" {
  ami             = "${data.aws_ami.rhel_ca_8_6.id}"
  instance_type   = "t2.micro"
  monitoring      = false
  key_name        = aws_key_pair.administator.key_name
  
  tags = {
    Name = "VPN-Gateway"
    Ansible_Group = "vpn-gateway"
  }

  root_block_device {
    delete_on_termination = true
  }


# Uncomment below if not using network_interface
  #subnet_id       = aws_subnet.public_subnet.id
  #associate_public_ip_address = true
  #vpc_security_group_ids = [aws_default_security_group.vpn-main-default-sec-group.id]

  network_interface {
    network_interface_id  = aws_network_interface.vpn-eni.id
    device_index          = 0
  }

  provisioner "remote-exec" {

  	inline = [ "sudo hostnamectl set-hostname ${var.instance_hostname}" ]

	connection {
		type		= "ssh"
		user		= "ec2-user"
		private_key 	= file("${var.private_key_path}")
		# aws_eip is associated after the instance is
    # successfully provisioned
    #host		= aws_eip.public_ip.public_ip
  	host		= self.public_ip
    }
	}
}


## Attach resources to EC2 Instance

# Associate Elastic Public IP to Provisioned Instance

resource "aws_eip_association" "eip_eni_assoc" {
  network_interface_id = aws_network_interface.vpn-eni.id
  allocation_id = aws_eip.vpn-main-public-ip.id
}

resource "aws_volume_attachment" "ebs_database" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.database.id
  instance_id = aws_instance.vpn-gateway.id
}