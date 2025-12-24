resource "aws_vpc" "eks-project-vpc" {
  cidr_block       = var.vpc_cidr
  region = var.region

  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_subnet" "public-eks-1" {
  vpc_id     = aws_vpc.eks-project-vpc.id
  cidr_block = var.public-eks-1-cidr
  availability_zone = var.az-1


  tags = {
    Name = "eks-public-subnet-1"
  }
}

resource "aws_subnet" "public-eks-2" {
  vpc_id     = aws_vpc.eks-project-vpc.id
  cidr_block = var.public-eks-2-cidr
  availability_zone = var.az-2


  tags = {
    Name = "eks-public-subnet-2"
  }
}


resource "aws_subnet" "private-eks-1" {
  vpc_id     = aws_vpc.eks-project-vpc.id
  cidr_block = var.private-eks-1-cidr
  availability_zone = var.az-1


  tags = {
    Name = "eks-private-subnet-1"
  }
}

resource "aws_subnet" "private-eks-2" {
  vpc_id     = aws_vpc.eks-project-vpc.id
  cidr_block = var.private-eks-2-cidr
  availability_zone = var.az-2


  tags = {
    Name = "eks-private-subnet-2"
  }
}

resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-project-vpc.id

  tags = {
    Name = "eks-igw"
  }
}


resource "aws_nat_gateway" "eks-nat" {
  subnet_id     = aws_subnet.public-eks-1.id
   allocation_id = aws_eip.nat.id
  tags = {
    Name = "eks-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.eks-igw]
}

resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.eks-igw]
}




resource "aws_route_table" "eks-route-table-public" {
  vpc_id = aws_vpc.eks-project-vpc.id

  route {
    cidr_block = var.route-table-cidr
    gateway_id = aws_internet_gateway.eks-igw.id
  }

  tags = {
    Name = "eks-route-table-public"
  }
}


resource "aws_route_table" "eks-route-table-private" {
  vpc_id = aws_vpc.eks-project-vpc.id

  route {
    cidr_block = var.route-table-cidr
    nat_gateway_id = aws_nat_gateway.eks-nat.id
  }

  tags = {
    Name = "eks-route-table-private"
  }
}


resource "aws_route_table_association" "subnet_association_1" {
  subnet_id    = aws_subnet.public-eks-1.id
  route_table_id = aws_route_table.eks-route-table-public.id
}


resource "aws_route_table_association" "subnet_association_2" {
  subnet_id    = aws_subnet.public-eks-2.id
  route_table_id = aws_route_table.eks-route-table-public.id
}

resource "aws_route_table_association" "private_associations" {
  subnet_id    = aws_subnet.private-eks-1.id
  route_table_id = aws_route_table.eks-route-table-private.id
}

resource "aws_route_table_association" "private_associations-2" {
  subnet_id    = aws_subnet.private-eks-2.id
  route_table_id = aws_route_table.eks-route-table-private.id
}


resource "aws_security_group" "eks-sg" {
  name        = "eks-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.eks-project-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.eks-sg.id
  cidr_ipv4         = var.allow_all_traffic_cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.eks-sg.id
  cidr_ipv4         = var.allow_all_traffic_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.eks-sg.id
  cidr_ipv4         = var.allow_all_traffic_cidr
  ip_protocol       = "-1" # semantically equivalent to all ports
}
