# EKS-deployment


## Overview 

Deployment of the 2048 game using scalable production ready infrastructure on Amazon EKS with complete automation using Terraform, GitOps using ArgoCD, Monitoring using Grafana, Security scanning with Checkov and Trivy

![alt text](image.png)



## Features  
- ExternalDNS: Automated DNS record management in route53
- Cert-manager: DNS validation and cert management  
- HELM: Orchestrate K8S deployments  
- Prometheus and Grafana: Provides cluster metrics and utilises neat dashboards for visualisation 
- Amazon EBS CSI driver introducing persistent storage for prometheus 
- OIDC: Web tokens rather than providing access keys mitigating security risks implementing security best practices 

## Architecture diagram 

## Docker 
- Implemented multistage builds reducing image size by x%
- Non root user to tighten security and follow best practice 


## Terraform 
- S3 as a state backend using native locking to prevent concurrent changes and data loss 
- Leveraged Checkov security scanning in pipelines to enforce best practice and mitigate security vulnerabilities 
- Modular structure for clean code 
- Enforced DRY principle through the use of variables 


## Kubernetes 
- Created Ingresses to expose services to the internet e.g. Grafana GUI, Prometheus, 2048 game, ArgoCD 
- Leveraged HELM for easy and smooth deployment, utilising helmfile to deploy all resources using a single command

## CI/CD 
- Builds, Tags, Pushes Dockerfile to ECR repo automated with GitHub actions
- Manual workflow to prevent accidental deployments
- Security scanning ensuring infrastructure is production grade ready

## Grafana & Prometheus 










## ArgoCD








