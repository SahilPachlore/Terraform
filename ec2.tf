terraform {
  required_providers {
    aws={
      source = "hashicorp/aws"
      
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_instance" "linux_server" {
    ami = " "
    instance_type = "t3.micro"
    # count = "5"
  
}
 