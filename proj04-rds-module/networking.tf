data "aws_vpc" "default" {
  default = true
}

resource "aws_vpc" "custom" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "proj-04-custom"
  }
}

moved {
  from = aws_subnet.allowed
  to = aws_subnet.private1
}


resource "aws_subnet" "private1" {
  vpc_id = aws_vpc.custom.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-west-1a"

  tags = {
    Name = "subnet-custom-vpc-1"
    Access = "private"
  }
}

resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.custom.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "subnet-custom-vpc-2"
    Access = "private"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.custom.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "subnet-custom-vpc-3"
  }
}



# For documentation. Not being use
resource "aws_subnet" "not_allowed" {
  vpc_id = data.aws_vpc.default.id
  cidr_block = "172.31.128.0/24"
  tags = {
    Name = "subnet-default-vpc"
  }
}


resource "aws_security_group" "source" {
  name = "source-sg"
  vpc_id = aws_vpc.custom.id
}

resource "aws_security_group" "compliant" {
  name = "compliant-sg"
  vpc_id = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id = aws_security_group.compliant.id
  referenced_security_group_id = aws_security_group.source.id
  from_port = 5432
  to_port = 5432
  ip_protocol = "tcp"
  
}

resource "aws_security_group" "non_compliant" {
  name = "non-compliant-sg"
  vpc_id = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.non_compliant.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
  
}