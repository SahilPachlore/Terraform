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
resource "aws_instance" "linux1_server" {
    ami = var.ami
    instance_type = var.instance_type
    # count = "5"
  
}
output " public_ip" {
    value = "aws_instance.linux1_server.public_ip "
} 