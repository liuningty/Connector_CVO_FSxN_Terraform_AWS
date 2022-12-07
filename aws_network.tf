# create VPC
resource "aws_vpc" "vpc_bluexp" {
  cidr_block           = "20.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-bluexp"
  }

}

# create IGW
resource "aws_internet_gateway" "igw_bluexp" {
  vpc_id = aws_vpc.vpc_bluexp.id
}

# create route table
resource "aws_route_table" "internet_route_bluexp" {
  vpc_id = aws_vpc.vpc_bluexp.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_bluexp.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "vpc-bluexp-RT"
  }
}

# overwrite default route table of VPC with created route table entries
resource "aws_main_route_table_association" "set-default-rt-assoc" {
  vpc_id         = aws_vpc.vpc_bluexp.id
  route_table_id = aws_route_table.internet_route_bluexp.id
}

# get all available AZ's in VPC
data "aws_availability_zones" "azs" {
  state = "available"
}

# create subnet #1
resource "aws_subnet" "subnet_1" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_bluexp.id
  cidr_block        = "20.0.1.0/24"
  tags = {
    Name = "subent_20.0.1.0/24"
  }
}

# create subnet #2 
resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.vpc_bluexp.id
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  cidr_block        = "20.0.2.0/24"
  tags = {
    Name = "subent_20.0.2.0/24"
  }
}

# create subnet #3
resource "aws_subnet" "subnet_3" {
  vpc_id            = aws_vpc.vpc_bluexp.id
  availability_zone = element(data.aws_availability_zones.azs.names, 2)
  cidr_block        = "20.0.3.0/24"
  tags = {
    Name = "subent_20.0.3.0/24"
  }
}

# create SG for allowing SSH, HTTP, HTTPS access
resource "aws_security_group" "sg_bluexp" {
  name        = "sg_bluexp"
  description = "Allow SSH & HTTP & HTTPS"
  vpc_id      = aws_vpc.vpc_bluexp.id
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}