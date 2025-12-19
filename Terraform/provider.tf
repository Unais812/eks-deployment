terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.14.0"
    }
  }

  backend "s3" {
    bucket = "eks-deployment-s3"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"
}

provider "helm" {
  kubernetes = {
    host        = module.eks.eks-cluster-endpoint
    config_path = "~/.kube/config"
  }
}