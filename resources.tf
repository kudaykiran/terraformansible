#RESOURCE VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block_range
  enable_dns_support   = true
  enable_dns_hostnames = true
}


#RESOURCE internet_gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}


#RESOURCE subnet
resource "aws_subnet" "subnet_public" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet1_cidr_block_range
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone
}


#RESOURCE route_table
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
}


#RESOURCE route_table_association
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}


#RESOURCE key_pair
resource "aws_key_pair" "ec2" {
  key_name = "mykey1"
  public_key = file(var.public_key_path)
}


#RESOURCE security_group1	
resource "aws_security_group" "sg_22" {
  name = "sg_22"
  vpc_id = var.vpc_id

  # SSH access from the VPC
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



#RESOURCE security_group2
resource "aws_security_group" "sg_80" {
  name = "sg_80"
  vpc_id = var.vpc_id

  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#RESOURCE instance
resource "aws_instance" "instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id = var.subnet_public_id
  vpc_security_group_ids = var.security_group_ids
  key_name = aws_key_pair.ec2.key_name
  user_data = <<-EOF
				#!/bin/bash
				apt-get install ansible -y
				echo "ansible -version"
				apt-get install httpd -y
				echo "hello welcome to ec2 instance" > /var/www/html/index.html
				service httpd start
				chkconfig httpd on
				EOF
}