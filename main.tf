# launch template used to create instances and autoscaling group
#resource "aws_launch_template" "amitemp" {
#  name_prefix   = "section1"
#  vpc_security_group_ids = [aws_security_group.load-balancer.id]
#  image_id      = "ami-0a55cdf919d10eac9"
#  instance_type = "t2.micro"
#  placement {
#    availability_zone = "us-west-2a"
#  }
#}

#resource "aws_autoscaling_group" "ec2-cluster" {
#  desired_capacity   = 3
#  max_size           = 5
#  min_size           = 3
#  health_check_type  = "EC2"
  # vpc_zone_identifier = [aws_subnet.private_subnets[0].id, aws_subnet.private_subnets[1].id, aws_subnet.private_subnets[2].id]
#  vpc_zone_identifier = [aws_subnet.public_subnets[0].id, aws_subnet.public_subnets[1].id, aws_subnet.public_subnets[2].id]
#  target_group_arns = [aws_alb_target_group.default-target-group.arn]
#  # took out azs and replaced with vpc_zone_identifier
  # connects vpc in autoscaling group

  # launch_template now preferred to launch configuration
#  launch_template {
#    id      = aws_launch_template.amitemp.id
#    version = "$Latest"

#  }
# }

# EC2 instances
resource "aws_instance" "my-machine" {
  # Creates three identical aws ec2 instances
  count = 3

  # All three instances will have the same ami and instance_type
  ami                    = lookup(var.ec2_ami, var.region)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2.id]
  subnet_id              = aws_subnet.public_subnets[count.index].id

  # install and run nginx on ec2 instances
  user_data = file("userdata.tpl")

  tags = {
    # count.index allows you to launch a resource starting with 
    # the distinct index number 0 and corresponding to this instance.
    Name = "my-machine-${count.index}"
  }
}

# Instance Security group (traffic ELB -> EC2, ssh -> EC2)
resource "aws_security_group" "ec2" {
  name        = "ec2_security_group"
  description = "Allows inbound access from the ALB only"
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
    # using 0.0.0.0/0 enables all IPv4 addresses to access our instances using ssh
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

  # ingress {
  #  from_port       = 0
  #  to_port         = 0
  #  protocol        = "-1"
  #  security_groups = [aws_security_group.load-balancer.id]
  #}

  #ingress {
  #  from_port   = 22
  #  to_port     = 22
  #  protocol    = "tcp"
  #  cidr_blocks = ["0.0.0.0/0"]
  #  # using 0.0.0.0/0 enables all IPv4 addresses to access our instances using ssh
  #}

  #egress {
  #  from_port   = 0
  #  to_port     = 0
  #  protocol    = "-1"
  #  cidr_blocks = ["0.0.0.0/0"]
  #}
#}

# attach ec2 instances to autoscaling group
#resource "aws_autoscaling_attachment" "asg_attachment_bar" {
#  autoscaling_group_name = aws_autoscaling_group.ec2-cluster.id
#  lb_target_group_arn    = aws_alb_target_group.default-target-group.arn
#}

