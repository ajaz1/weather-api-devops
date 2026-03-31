# DevOps Take-Home Challenge: Scalable API Deployment

## Overview
You are provided with a Go-based Weather API application that includes a Dockerfile. Your task is to deploy this API in a scalable, production-ready manner using Infrastructure as Code (IaC) and Configuration Management tools.

## The Application

The Weather API provides three endpoints:
- `GET /health` - Health check endpoint
- `GET /weather` - Returns weather data (increments error counter)
- `GET /metrics` - Exposes metrics including a simulated error counter

The application is containerized and ready to deploy.

## Your Mission

Deploy this API with the following requirements:

### 1. Infrastructure Provisioning (Terraform)
- Set up a **container registry** for the API image (can be hosted on one of the Hetzner instances or use an external registry)
- Provision infrastructure for **two environments** (dev and prod) using Hetzner Cloud
- Set up at least **2 API instances** per environment for high availability
- Provision a **database instance** per environment (PostgreSQL or MySQL)
   - The API doesn't use it yet, but will in the future
- Implement a load balancing solution to distribute traffic across API instances (Hetzner Load Balancer or software-based solution)

### 2. CI/CD Concept
- Describe how you would build and push the Docker image to your registry
- Document the deployment workflow (this doesn't need to be fully automated, a clear description is sufficient)

### 3. Configuration Management (Ansible)
- Configure all VMs/instances
- Deploy and run the API containers
- Set up the database server
- Ensure services start automatically on boot

### 4. Architecture Considerations
We want to see your thinking around:
- **Scalability**: How would you scale up/down the API instances?
- **Security**: How would you secure the infrastructure?
- **Reliability**: What happens when the database server fails? And how to avoid it?

## Infrastructure

Use **Hetzner Cloud** to create your infrastructure:
- You will receive a **Hetzner Cloud API token** to provision resources
- Use Terraform with the official Hetzner Cloud provider (`hetznercloud/hcloud`)
- Choose appropriate server types (e.g., CX22 or smaller for cost efficiency)
- **Important**: Be mindful of costs - use small instance types and tear down resources when not actively working on the challenge

## Deliverables

1. **Infrastructure Code**
   - Terraform configuration files
   - Well-structured, modular code
   - Variables and outputs properly defined
   - Include a `terraform.tfvars.example` file showing required variables (API token should be passed as variable, not hardcoded)

2. **Configuration Management**
   - Ansible playbooks and roles
   - Inventory files (static or dynamic)
   - Clear role separation

3. **Documentation** (README.md)
   - Architecture diagram or description
   - Prerequisites and setup instructions
   - How to deploy the infrastructure
   - How to verify the deployment works
   - How to scale up/down
   - How to tear down everything (important for cost management!)
   - Any assumptions or design decisions you made

## Evaluation Criteria

We will assess:
- **Code Quality**: Clean, readable, well-structured IaC code
- **Best Practices**: Security, scalability, and reliability considerations
- **Documentation**: Clear instructions and architectural thinking
- **Creativity**: Innovative solutions and bonus features
- **Completeness**: Does everything work as described?
- **Cost Awareness**: Appropriate instance sizing and clear teardown procedures

## Time Expectation

You have **1 week** to complete this challenge, but you can submit at any time once you're satisfied with your solution. If you need more time due to other commitments, just let us know.

**Note on Costs**: We understand that Hetzner Cloud incurs costs. Please be mindful of this and tear down your infrastructure when not actively working. Document your estimated costs in your README. The total cost for this challenge should be minimal (a few euros) if resources are managed properly.

## Submission

Please provide:
- Git repository (GitHub, GitLab, etc.) with all code and documentation
- Ensure the repository includes clear instructions to reproduce your setup
- Include any configuration files, scripts, or additional resources needed
- **Do not commit your Hetzner API token** - use `.gitignore` and provide examples instead

## Questions?

If anything is unclear, feel free to reach out. We prefer you make reasonable assumptions and document them rather than getting blocked.

---

**Good luck! We're excited to see your approach to this challenge.**