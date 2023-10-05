#######################
# Note on outputs on AWS Dashboard:
#######################
# you will see that us-east-2 has 4 instances (because the vpc is connected in that region
# and we deploy the instance (with same ami id) across 2 AZs and has a security group for
# ec2 security group and load balancer)
# us-east-1 only has one ec2 instance because we did not deploy the vpc across multiple regions 
# (only deployed the vpc in one region and across 2 zones) 
# however, we will see that on HCP dashboard, the ec2 instances in us-east-1 and us-east-2 are deployed
# to different channels but on same iteration (v4)

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

output "ubuntu_iteration_2" {
  value = data.hcp_packer_iteration.ubuntu-2
}

output "ubuntu_us_east_2" {
  value = data.hcp_packer_image.ubuntu_us_east_2
}

output "ubuntu_iteration_1" {
  value = data.hcp_packer_iteration.ubuntu-1
}
output "ubuntu_us_east_1" {
  value = data.hcp_packer_image.ubuntu_us_east_1
}