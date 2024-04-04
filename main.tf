
resource "aws_instance" "my-machine" {

  # Creates three identical aws EC2 instances
  count = 3

  # All three instances will have the same ami and instance_type
  ami                    = lookup(var.ec2_ami, var.region)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2.id]
  subnet_id              = aws_subnet.public_subnets[count.index].id
  associate_public_ip_address = true

  # install and run apache2 on ec2 instances
  user_data = file("userdata.tpl")

  tags = {
    Name = "my-machine-${count.index}"
    # count.index allows you to launch a resource starting with 
    # the distinct index number 0 and corresponding to this instance.
  }
}

# Instance Security group (traffic ELB -> EC2, ssh -> EC2)
resource "aws_security_group" "ec2" {
  name        = "ec2_security_group"
  description = "Allows ssh http inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "SSH from VPC"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    # using 0.0.0.0/0 for cidr enables all IPv4 addresses to access our instances using ssh
  }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
# }
