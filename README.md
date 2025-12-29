# EKS-deployment


## Overview 

Deployment of the 2048 game using scalable production ready infrastructure on Amazon EKS with complete automation using Terraform, GitOps using ArgoCD, Monitoring using Grafana, Security scanning with Checkov and Trivy


<img width="1512" height="982" alt="Screenshot 2025-12-27 at 23 54 55" src="https://github.com/user-attachments/assets/f24a6070-0d2f-40ea-92b5-0eb0a3a9140c" />



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
- Modular structure for clean code 
- Enforced DRY principle through the use of variables 


## Kubernetes 
- Created Ingresses to expose services to the internet 
- Leveraged HELM for easy and smooth deployment, utilising helmfile to deploy all resources using a single command

## CI/CD 
- Builds, Tags, Pushes Dockerfile to ECR repo automated with GitHub actions
- Manual workflow to prevent accidental deployments
- Security scanning ensuring infrastructure is production grade ready

## Grafana & Prometheus 

<img width="1512" height="982" alt="Screenshot 2025-12-29 at 00 09 49" src="https://github.com/user-attachments/assets/e5440476-875c-4426-af84-a90529d85678" />


<img width="1512" height="982" alt="Screenshot 2025-12-29 at 00 23 47" src="https://github.com/user-attachments/assets/c1851ade-c1d5-464e-9159-048216d4c8b9" />









## ArgoCD








