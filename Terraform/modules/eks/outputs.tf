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

output "pod-role-name" {
  value = aws_iam_role.pod-role-ec2registry.name
}

output "pod-role-arn" {
  value = aws_iam_role.pod-role-ec2registry.arn
}

output "CertManager-pod-name" {
  value = aws_iam_role.CertManager-pod.name
}

output "CertManager-pod-arn" {
  value = aws_iam_role.CertManager-pod.arn
}

output "eks-cluster-endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "eks-node-group-id" {
  value = aws_eks_node_group.eks-node-group.id
}

output "external-dns-policy-arn" {
  value = aws_iam_policy.external-dns-policy.arn
}

output "external-dns-role-name" {
  value = aws_iam_role.external-dns-role.name
}

output "external-dns-role-arn" {
  value = aws_iam_role.external-dns-role.arn
}

