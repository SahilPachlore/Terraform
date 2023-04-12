terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}
provider "aws" {
    region = ""
    access_key = ""
    secret_key = ""
}
resource "aws_vpc" "main_vpc" {
    cidr_block = "18.0.0.0/20"

    tags = {
      Name = "main-VPC"
    }
  
}

resource "aws_subnet" "main" {
    vpc_id = ""
    cidr_block = ""
    tags = {
      Name = "main"
    }
  
}

