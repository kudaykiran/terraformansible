variable "AWS_ACCESS_KEY" {
    type = string
}
variable "AWS_SECRET_KEY" {
    type = string
}
variable "region" {
  default = "us-east-1"
}
variable "availability_zone" {
  default = "us-east-1c"
}
variable "vpc_id" {
  description = "VPC id"
  default = ""
}
variable "subnet_public_id" {
  description = "VPC public subnet id"
  default = ""
}
variable "security_group_ids" {
  description = "EC2 ssh security group"
  type =list
  default = ["sg_22", "sg_80"]
}

variable "key_pair_name" {
  description = "EC2 Key pair name" 
  default = "mykey1"
}
variable "public_key_path" {
  description = "Public key path"
  default = "mykey1.pub"
}
variable "instance_ami" {
  description = "EC2 instance ami"
  default = "ami-0817d428a6fb68645"
}
variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}
variable "cidr_block_range" {
  description = "The CIDR block for the VPC"
  default = "10.1.0.0/16"
}
variable "subnet1_cidr_block_range" {
  description = "The CIDR block for public subnet of VPC"
  default = "10.1.0.0/24"
}