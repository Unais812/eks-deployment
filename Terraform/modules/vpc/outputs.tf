output "vpc_id" {
  value = aws_vpc.eks-project-vpc.id
}

output "eks-igw" {
  value = aws_internet_gateway.eks-igw.id
}

output "nat-igw" {
  value = aws_nat_gateway.eks-nat.id
}
output "public-eks-1-id" {
  value = aws_subnet.public-eks-1.id
}

output "public-eks-2-id" {
    value = aws_subnet.public-eks-2.id
}

output "private-eks-1-id" {
  value = aws_subnet.private-eks-1.id
}

output "private-eks-2-id" {
  value = aws_subnet.private-eks-2.id
}

output "eks-route-table-public-id" {
  value = aws_route_table.eks-route-table-public.id
}

output "eks-route-table-private-id" {
  value = aws_route_table.eks-route-table-private.id
}

output "eip" {
  value = aws_eip.nat.id
}