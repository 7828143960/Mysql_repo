locals {
  inbound_ports  = var.inbound_ports
  outbound_ports = var.outbound_ports
}

resource "aws_security_group" "sec_grp" {
  name        = "sec_grp"
  description = "Security group for EC2 instance"
  vpc_id = var.vpc_id

  dynamic "ingress" {
  for_each = local.inbound_ports
  content {
   from_port = ingress.value.port
   to_port = ingress.value.port
   protocol = ingress.value.protocol
   cidr_blocks = var.ingress_cidr_blocks
  }
 }
 dynamic "egress" {
  for_each = local.outbound_ports
  content {
   from_port = egress.value.port
   to_port = egress.value.port
   protocol = egress.value.protocol
   cidr_blocks = var.egress_cidr_blocks
  }
 }
  tags = {
    Name = var.sec_grp
  }
}

# Instances
resource "aws_instance" "bastion" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name  
  subnet_id = var.pub_sub_id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids = [aws_security_group.sec_grp.id]
  root_block_device {
    volume_size = var.volume_size
  }
  tags = {
    Name = var.bastion_instance_name
  }
}

resource "aws_instance" "private-ec2" {
  count = length(var.pvt_instance_name)
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name
  subnet_id = var.pvt_sub_id[count.index]
  vpc_security_group_ids = [aws_security_group.sec_grp.id]
  root_block_device {
    volume_size = var.volume_size
  }
  tags = {
    Name = var.pvt_instance_name[count.index]
    DB = var.pvt_instance_name_02
  }
}

# Genrate Key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Genrate pen Key 
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

# pem Key download in sysytem
resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}

