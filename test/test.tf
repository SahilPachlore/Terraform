terraform {
  required_providers {
    aws={
      source = "hashicorp/aws"
      
    }
  }
}
provider "aws" {
    region = "ap-northeast-1"
    access_key = "AKIA3TZF2BPDBGT45BVL"
    secret_key = "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"
}
resource "aws_instance" "linux_server" {
    ami = "ami-0cc8b0ca07fee465f"
    instance_type = "t2.micro"
    # count = "5"
  
}
output "public_ip" {
    value = "aws_instance.linux_server.public_ip "
} 