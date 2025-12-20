module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source           = "./modules/eks"
  private-subnet-1 = module.vpc.private-eks-1-id
  private-subnet-2 = module.vpc.private-eks-2-id
  vpc-id           = module.vpc.vpc_id
}

module "helm" {
  source = "./modules/helm"
  node-group = module.eks.eks-node-group-id

}