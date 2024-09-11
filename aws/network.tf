resource "aws_vpc" "vpc" {
  cidr_block                       = "192.168.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name    = "main-vpc"
  }
}

resource "aws_subnet" "web_public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "web-public-subnet-1a"
  }
}

resource "aws_subnet" "web_public_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name    = "web-public-subnet-1c"
  }
}

resource "aws_subnet" "db_private_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.168.21.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "db-public-subnet-1a"
  }
}

resource "aws_subnet" "db_private_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.168.22.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name    = "db-public-subnet-1c"
  }
}

resource "aws_route_table" "web_public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name    = "web-public-route-table"
  }
}

resource "aws_route_table" "db_private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name    = "db-private-route-table"
  }
}

resource "aws_route_table_association" "web_public_1a_route" {
  route_table_id = aws_route_table.web_public_route_table.id
  subnet_id      = aws_subnet.web_public_subnet_1a.id
}

resource "aws_route_table_association" "web_public_1c_route" {
  route_table_id = aws_route_table.web_public_route_table.id
  subnet_id      = aws_subnet.web_public_subnet_1c.id
}

resource "aws_route_table_association" "db_private_1a_route" {
  route_table_id = aws_route_table.db_private_route_table.id
  subnet_id      = aws_subnet.db_private_subnet_1a.id
}

resource "aws_route_table_association" "db_private_1c_route" {
  route_table_id = aws_route_table.db_private_route_table.id
  subnet_id      = aws_subnet.db_private_subnet_1c.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name    = "igw"
  }
}

resource "aws_route" "igw" {
  route_table_id         = aws_route_table.web_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}