resource "helm_release" "nginx" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "nginx-ingress"
  version    = "4.14.1"
  depends_on = [ aws_eks_node_group.eks-node-group ]

  create_namespace = true
  namespace = "nginx-ingress"
}


