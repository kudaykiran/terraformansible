output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "public_subnets" {
  value = ["${aws_subnet.subnet_public.id}"]
}
output "ec2keyName" {
  value = "${aws_key_pair.ec2.key_name}"
}
output "sg_22" {
  value = "${aws_security_group.sg_22.id}"
}

output "sg_80" {
  value = "${aws_security_group.sg_80.id}"
}
