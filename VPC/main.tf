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
    cidr_block = var.vpc_main_cidr

    tags = {
      Name = "main-VPC"
    }
  
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    count = length(var.public_subnet_cidr)
    cidr_block = element(var.public_subnet_cidr,count.index)
    availability_zone = element(var.availabilty_zones,count.index)
    map_public_ip_on_launch = true


     
    tags = {
      Name = "public_subnet $(count.index + 1)"

    }
  
}
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    count = length(var.private_subnet_cidr)
    cidr_block = element(var.private_subnet_cidr,count.index)
    availability_zone = element(var.availabilty_zones,count.index)
    map_public_ip_on_launch = false

     
    tags = {
      Name = "private_subnet $(count.index + 1)"

    }
  
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    "Name" = "gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "route_table"
  }
}

resource "aws_route_table_association" "a" {
  count = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public_subnet[*].id,count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "allow_rdp" {
  name        = "allow_rpd"
  vpc_id      = aws_vpc.main_vpc.id
  
  ingress {
    description      = "rdp"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  tags = {
    Name = "allow_rdp"
  }
}

resource "aws_instance" "public_servers" {
  ami           = "" //required
  instance_type = "t2.micro"
   key_name = " " //required
   count = length(var.public_subnet_cidr)
  subnet_id = element(aws_subnet.public_subnet[*].id,count.index)
  vpc_security_group_ids = [aws_security_group.allow_rdp.id]

  tags = {
    Name = "public"
  }
}

resource "aws_instance" "private_servers" {
  ami           = "" //required
  instance_type = "t2.micro"
   key_name = " " //required
  count = length(var.private_subnet_cidr)
  subnet_id = element(aws_subnet.private_subnet[*].id,count.index)
  vpc_security_group_ids = [aws_security_group.allow_rdp.id]

  tags = {
    Name = "private"
  }
}