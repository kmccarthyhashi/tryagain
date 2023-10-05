# aws region variable
variable "region" {
  default     = "us-east-2"

}

variable "key_name" {}
variable "private_key_path" {}


# define 3 private subnets
variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24"] # , "10.0.6.0/24"]
}

# define 3 azs that we want deploy across
variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-2a", "us-east-2b"] # "us-west-2c"]

}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  default     = "section2-instance"
}

variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/"
}

# Old code (can likely get ride of since integrated up above):
# Create a variable for 3 amis
# Deploy 3 amis across 3 different AZ's (do so via subnets)
# variable "ec2_ami" {
#   type = map(any)

#   default = {
#     us-west-2a = "ami-0a55cdf919d10eac9" # https://cloud-images.ubuntu.com/locator/ec2/
#     us-west-2b = "ami-0a55cdf919d10eac9"
#     us-west-2c = "ami-0a55cdf919d10eac9"

#   }
# }