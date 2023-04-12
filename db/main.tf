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

resource "aws_db_instance" "rds" {
  identifier = "db-terraform" 
  allocated_storage    = "20"
  engine               = "mysql"
  engine_version       = "8.0.27"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "admin123" 
  publicly_accessible = true
  
  storage_type = "gp2"

  tags =  {
    Name = "rds"
  }
}