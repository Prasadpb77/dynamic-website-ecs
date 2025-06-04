# provider.tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.15.1"
    }
  }
}
# Specify the provider and access details
provider "aws" {
    region     = var.aws_region
}