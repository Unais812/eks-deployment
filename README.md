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

<img width="630" height="676" alt="Screenshot 2025-12-29 at 19 32 06" src="https://github.com/user-attachments/assets/a507c660-4a6e-4c1d-89f3-d97127bb128e" />


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
- Utilised prebuilt dashboard leveraging clean visualisation
- pulls real time metrics directly from the cluster to provide accurate info 

<img width="1512" height="982" alt="Screenshot 2025-12-29 at 00 09 49" src="https://github.com/user-attachments/assets/e5440476-875c-4426-af84-a90529d85678" />


<img width="1512" height="982" alt="Screenshot 2025-12-29 at 00 23 47" src="https://github.com/user-attachments/assets/c1851ade-c1d5-464e-9159-048216d4c8b9" />



## ArgoCD
- Created an application manifest to automate deployment of my application through ArgoCD

<img width="1512" height="982" alt="Screenshot 2025-12-29 at 20 11 25" src="https://github.com/user-attachments/assets/2dc4e744-ecf2-498c-8962-79dff3a4c7fe" />


## The journey 
This project marks a signficant milestone in my journey as a 16 year old DevOps engineer \
6 months ago i had no clue what Linux was, and now i have built a whole automated deployment on AWS EKS \
The process was far from easy but we got there in the end \
This project taught me a lot about K8s and also a lot about myself \
I learnt that i could seriously stick to something and put all my time and effort into learning  \
Whilst doing this project i caught a nasty fever but i continued building and deploying because i knew my work wasnt finished \
Project 1, Fever 0 \
Thank you for taking the time to look at my project, the 2nd of many









