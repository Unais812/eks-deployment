resource "aws_eks_cluster" "eks-cluster" {
  name = "eks-cluster"
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
}

  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = var.version-k8s
  
  vpc_config {
    subnet_ids = [
      var.private-subnet-1,
      var.private-subnet-2
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSComputePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSBlockStoragePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSLoadBalancingPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSNetworkingPolicy
  ]
}



resource "aws_iam_role" "eks-cluster-role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = var.policy-arn
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSBlockStoragePolicy" {
  policy_arn = var.policy2-arn
  role       = aws_iam_role.eks-cluster-role.name
}


resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSComputePolicy" {
  policy_arn = var.policy3-arn
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSLoadBalancingPolicy" {
  policy_arn = var.policy4-arn
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSNetworkingPolicy" {
  policy_arn = var.policy5-arn
  role       = aws_iam_role.eks-cluster-role.name
}



resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name   = "vpc-cni"
  resolve_conflicts_on_update = "OVERWRITE" # Ensures AWS is source of truth and ignores manual changes
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name   = "coredns"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name   = "kube-proxy"
  resolve_conflicts_on_update = "OVERWRITE"
}




resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.eks-node-role.arn
  subnet_ids      = [var.private-subnet-1, var.private-subnet-2]
  ami_type = var.ami
  instance_types = [var.instance-type]
  
  scaling_config {
    desired_size = var.desired-size
    max_size     = var.max-size
    min_size     = var.min-size
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-policy-ec2,
    aws_iam_role_policy_attachment.node-policy-EKS_CNI,
    aws_iam_role_policy_attachment.node-policy-ec2_registry,
  ]
}



resource "aws_iam_role" "eks-node-role" {
  name = "eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node-policy-ec2" {
  policy_arn = var.node-policy-arn
  role       = aws_iam_role.eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "node-policy-EKS_CNI" {
  policy_arn = var.node-policy2-arn
  role       = aws_iam_role.eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "node-policy-ec2_registry" {
  policy_arn = var.node-policy3-arn
  role       = aws_iam_role.eks-node-role.name
}


data "aws_iam_policy_document" "pod-role-ec2registry" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "pod-role-ec2registry" {
  name               = "pod-role-ec2registry"
  assume_role_policy = data.aws_iam_policy_document.pod-role-ec2registry.json
}

resource "aws_iam_role_policy_attachment" "ecr-pull" {
  policy_arn = var.pod-iam-arn
  role       = aws_iam_role.pod-role-ec2registry.name
}

resource "aws_eks_pod_identity_association" "Ec2RegistryAccess" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  namespace       = "default"
  service_account = "ec2registry-sa"
  role_arn        = aws_iam_role.pod-role-ec2registry.arn
}




data "aws_iam_policy_document" "CertManager-pod" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "CertManager-pod" {
  name               = "CertManager-pod"
  assume_role_policy = data.aws_iam_policy_document.CertManager-pod.json
}

resource "aws_iam_role_policy_attachment" "CertManager-pod" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess"
  role       = aws_iam_role.CertManager-pod.name
}

resource "aws_eks_pod_identity_association" "example" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  namespace       = "cert-manager"   # namespace created by the helm chart
  service_account = "external-dns-controller"
  role_arn        = aws_iam_role.CertManager-pod.arn
}


data "aws_iam_policy_document" "external-dns-assume" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}


data "aws_iam_policy_document" "external-dns-policy-document" {
  statement {
    effect = "Allow"

    actions = [
      "route53:ChangeResourceRecordSets"
    ]

    resources = [
      "arn:aws:route53:::hostedzone/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource"
    ]

    resources = ["*"]
  }
}




resource "aws_iam_role" "external-dns-role" {
  name               = "external-dns-role"
  assume_role_policy = data.aws_iam_policy_document.external-dns-assume.json
}

resource "aws_iam_policy" "external-dns-policy" {
  name   = "external-dns-route53"
  policy = data.aws_iam_policy_document.external-dns-policy-document.json
}

resource "aws_iam_role_policy_attachment" "external-dns-attachment" {
  policy_arn = aws_iam_policy.external-dns-policy.arn
  role       = aws_iam_role.external-dns-role.name
}

resource "aws_eks_pod_identity_association" "external-dns-pod-association" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  namespace       = "external-dns"
  service_account = "external-dns"
  role_arn        = aws_iam_role.external-dns-role.arn
}

