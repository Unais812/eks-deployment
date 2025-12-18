variable "version-k8s" {
  description = "version of k8s"
  type = string
  default = "1.31" 
}


variable "private-subnet-1" {
  description = "id of the first private subnet"
  type = string
}

variable "private-subnet-2" {
  description = "id of the second private subnet"
  type = string
}

variable "policy-arn" {
    description = "arn of the policy"
    type = string
    default = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

variable "policy2-arn" {
  description = "arn for the block storage policy"
  type = string
  default = "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"
}


variable "policy3-arn" {
  description = "arn for the eks compute policy"
  type = string
  default = "arn:aws:iam::aws:policy/AmazonEKSComputePolicy"
}

variable "policy4-arn" {
  description = "arn for the load balancing policy"
  type = string
  default = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
}

variable "policy5-arn" {
  description = "arn for the eks networking policy"
  type = string
  default = "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
}

variable "node-policy-arn" {
  description = "arn of the node policy for EC2 container service"
  type = string
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

variable "node-policy2-arn" {
  description = "arn of the node policy for EKS_CNI"
  type = string
  default = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

variable "node-policy3-arn" {
  description = "arn of the node policy for EC2_REGISTRY"
  type = string
  default = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

variable "vpc-id" {
  description = "id of the vpc for cluster"
  type = string
}

variable "ami" {
  description = "ami for the node groups"
  type = string
  default = "AL2023_x86_64_STANDARD"
}

variable "instance-type" {
  description = "instance type for the node groups"
  type = string
  default = "t3.medium"
}

variable "desired-size" {
  description = "desired amount of node groups"
  type = number
  default = 2
}

variable "max-size" {
  description = "max amount of node groups"
  type = number
  default = 3
}

variable "min-size" {
  description = "minimum amount of node groups"
  type = number
  default = 1
}

variable "principal-arn" {
  description = "arn of the IAM principal to create an access entry"
  type = string
  default = "arn:aws:iam::801822495646:user/unais812"
}

variable "pod-iam-arn" {
  description = "policy of the pod to pull ecr images"
  type = string
  default = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}