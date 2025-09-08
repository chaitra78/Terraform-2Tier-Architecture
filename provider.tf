provider "aws" {
  region = "us-east-1"
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"                # This means any version >= 5.0.0 and < 6.0.0
    }
  }
}
