# Return concatenated name assigned to elb
output "elb_name" {
 description = "The DNS name of the ELB"
 value = aws_elb.elb.name
}

# Return the specific aws domain name associated with elb
output "elb_dns_name" {
 description = "The DNS name of the ELB"
 value = aws_elb.elb.dns_name
}

# Return the value of the security group identifier
output "elb_source_security_group_id" {
 value = aws_elb.elb.source_security_group_id
}

output "web_instance_ip_0" {
  value = aws_instance.my-machine[0].public_ip
}
output "web_instance_ip_1" {
  value = aws_instance.my-machine[1].public_ip
}
output "web_instance_ip_2" {
  value = aws_instance.my-machine[2].public_ip
}
