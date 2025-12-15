variable "vpc_cidr" {
    description = "cidr for the vpc"
    type = string
    default = "10.0.0.0/16"
}

variable "region" {
    description = "region"
    type = string
    default = "eu-north-1"
}

variable "public-eks-1-cidr" {
  description = "cidr for the subnet"
  type = string
  default = "10.0.1.0/24"
}

variable "az-1" {
  description = "az for the first set of subnets"
  type = string
  default = "eu-north-1a"
}

variable "public-eks-2-cidr" {
  description = "cidr for the subnet"
  type = string
  default = "10.0.2.0/24"
}

variable "az-2" {
  description = "az for the first set of subnets"
  type = string
  default = "eu-north-1b"
}

variable "private-eks-1-cidr" {
  description = "cidr for the subnet"
  type = string
  default = "10.0.3.0/24"
}

variable "private-eks-2-cidr" {
  description = "cidr for the subnet"
  type = string
  default = "10.0.4.0/24"
}

variable "route-table-cidr" {
  description = "cidr for the public route"
  type = string
  default = "0.0.0.0/0"
}