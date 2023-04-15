terraform {
  required_providers {
    aws={
      source = "hashicorp/aws"
      
    }
  }
}
provider "aws" {
    region = "eu-west-2"
    access_key = " "
    secret_key = " "
}
resource "aws_instance" "linux1_server" {
    ami = "ami-0cd8ad123effa531a"
    instance_type = "t2.micro"
   
  
}
output "public_ip" {
    value = aws_instance.linux1_server.public_ip 
} 
