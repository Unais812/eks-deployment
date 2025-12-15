output "eks-cluster-role-arn" {
    value = aws_iam_role.eks-cluster-role.arn
}

output "eks-cluster-role-name" {
  value = aws_iam_role.eks-cluster-role.name
}

output "cluster-name" {
  value = aws_eks_cluster.eks-cluster.name
}

output "node-role-arn" {
  value = aws_iam_role.eks-node-role.name
}

output "eks-node-role-arn" {
  value = aws_iam_role.eks-node-role.arn
}