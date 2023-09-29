terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

# define aws provider that we're using
provider "aws" {
  region     = var.aws_region
}

########################
# AWS Credentials note:
# chose not to include creds in .tfvars file as this is no longer recommended
# will manually enter creds on CLI for now. Future iteration could be performed 
# in TFC to streamline the operation
########################

