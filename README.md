# Scalable Weather API Deployment on Hetzner Cloud

## Project Overview

This project demonstrates how to deploy a containerized Go-based Weather API in a scalable and production-style environment using Infrastructure as Code and configuration management tools.

The goal was to design a reliable, scalable architecture using:

- Terraform for infrastructure provisioning
- Ansible for configuration management
- Docker for container deployment
- Hetzner Cloud as the infrastructure provider
- Load balancing for high availability

Two environments were deployed:

- **Development (dev)**
- **Production (prod)**

Each environment contains multiple API instances behind a load balancer and a dedicated database server.

---

# Architecture Overview

Each environment consists of:

- 2 API servers running Docker containers
- 1 Database server (PostgreSQL)
- 1 Hetzner Load Balancer
- SSH-based configuration via Ansible

Traffic Flow:

User → Load Balancer → API Servers → Database

The load balancer distributes incoming traffic across API servers using round-robin strategy and performs health checks to ensure availability.

---

# Infrastructure Provisioning (Terraform)

Infrastructure is provisioned using Terraform with the Hetzner Cloud provider.

For each environment:

- 2 API Servers
- 1 Database Server
- 1 Load Balancer
- SSH key integration
- Health-checked load balancing

Server Details:

- Server Type: `cx23`
- OS: Ubuntu 22.04
- Location: `nbg1`
- Load Balancer Type: `lb11`

Terraform structure:

terraform/
├── modules/
│ └── environment/
├── envs/
│ ├── dev/
│ └── prod/
├── provider.tf
├── variables.tf



---

# Configuration Management (Ansible)

After infrastructure creation, Ansible configures all servers.

Tasks performed:

### API Servers

- Install Docker
- Pull Weather API container
- Start container
- Expose port `8080`
- Enable auto-start on reboot

### Database Server

- Install PostgreSQL
- Start PostgreSQL service
- Enable service on boot

Ansible structure:

ansible/
├── inventory.ini
├── site.yml
├── roles/
│ ├── docker/
│ ├── api/
│ └── database/


---

# Container Registry

Docker Hub was used as the container registry.

Image:

ajzsdk/weather-api:latest


Image build process:

```bash
docker build -t ajzsdk/weather-api:latest .
docker push ajzsdk/weather-api:latest


API Endpoints
-------------
Health Check:

GET /health

Weather Data:

GET /weather

Metrics:

GET /metrics


# Architecture Flow:

Client Request
       |
       v
Hetzner Load Balancer
       |
 -------------------------
 |                       |
API Server 1        API Server 2
       |
       v
PostgreSQL Database
