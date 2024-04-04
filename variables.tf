# aws region variable
variable "aws_region" {
  description = "AWS Region to launch servers"
  default     = "us-west-2"

}

variable "key_name" {}
variable "private_key_path" {}


# define 3 public subnets
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}

# define 3 azs that we want deploy across
variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]

}

# Create a Variable for region
variable "region" {
  default = "us-west-2a"
}

# Create a variable for 3 amis
# Deploy 3 amis across 3 different AZ's (do so via subnets)
variable "ec2_ami" {
  type = map(any)

  default = {
    us-west-2a = "ami-0a55cdf919d10eac9" # https://cloud-images.ubuntu.com/locator/ec2/
    us-west-2b = "ami-0a55cdf919d10eac9"
    us-west-2c = "ami-0a55cdf919d10eac9"

  }
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  default     = "section1-instance"
}

variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/"
}
