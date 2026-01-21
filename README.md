TERRAFORM AZURE LAB – Modular, Multi‑Environment Infrastructure
This project automates the deployment of a complete Azure infrastructure using Terraform, modular IaC design, and GitHub Actions. It provisions virtual networks, subnets, network security groups, Linux virtual machines, and monitoring resources — all deployed through a secure, environment‑aware CI/CD pipeline.


PROJECT OVERVIEW
This repository follows a multi‑environment Terraform architecture, separating staging and production deployments while sharing reusable modules.


Terraform Modules Used
The infrastructure is broken into three core modules:
1. Networking Module ()


Creates all network‑related resources:


• 	Virtual Network ()
• 	Frontend subnet
• 	Backend subnet
• 	Network Security Groups for each subnet
• 	NSG → Subnet associations

2. Compute Module ()


Deploys compute resources:


• 	Frontend Linux VM

• 	Backend Linux VM

• 	NICs for each VM

• 	Public IP for the frontend VM

• 	Admin credentials (password + SSH key)



3. Monitoring Module ()


Provides observability:

• 	Log Analytics Workspace

• 	Diagnostic settings (optional extension point)


ENVIRONMENT STRUCTURE
Each environment has its own folder under :


Staging

environments/staging/


    backend.tf

    main.tf

    variables.tf

    staging.tfvars


Production


environments/production/

    backend.tf

    main.tf

    variables.tf

    production.tfvars


Each environment includes:

- Its own remote backend configuration
- Its own variable definitions
- Its own .tfvars file
- Its own state file in Azure Storage
This ensures complete isolation between staging and production.

GITHUB ACTIONS WORKFLOW
All workflows are located in

.github/workflows/deploy.yml

Workflow: deploy.yml
Purpose:
Primary Terraform deployment pipeline for both staging and production.
Features:
- Manual environment selection (workflow_dispatch)
- Azure authentication using Service Principal
- Terraform init → plan → apply
- Environment‑specific backend + variable loading
- Automatic plan summary output
- Safe apply logic with environment protection


SECRETS REQUIRED
Set the following secrets in your GitHub repository:
1. AZURE_CREDENTIALS
Azure Service Principal credentials in JSON format:
- clientId
- clientSecret
- tenantId
- subscriptionId
2. ADMIN_PASSWORD
Secure password for VM admin user.
3. ADMIN_SSH_PUBLIC_KEY
SSH public key for Linux VM authentication.

FILE STRUCTURE 

.github/workflows/

    deploy.yml


environments/

    staging/

        backend.tf

        main.tf

        variables.tf

        staging.tfvars


    production/

        backend.tf

        main.tf

        variables.tf

        production.tfvars


modules/

    networking/

        main.tf

        variables.tf

        outputs.tf

    compute/

        main.tf

        variables.tf

        outputs.tf

    monitoring/

        main.tf

        variables.tf

        outputs.tf


.gitignore


README.md