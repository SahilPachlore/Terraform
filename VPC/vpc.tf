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
    cidr_block = "172.21.0.0/16"

    tags = {
      Name = "exercise6-vpc"
    }
  
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "172.21.1.0/24"
    availability_zone = ""

}