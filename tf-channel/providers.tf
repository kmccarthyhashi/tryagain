terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.72.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

provider "hcp" {}

# define aws provider that we're using
provider "aws" {
  region     = var.region
}

provider "aws" {
  alias = "reg_one"
  region = "us-east-1"
}


########################
# AWS Credentials note:
# chose not to include creds in .tfvars file as this is no longer recommended
# will manually enter creds on CLI for now. Future iteration could be performed 
# in TFC to streamline the operation
########################

