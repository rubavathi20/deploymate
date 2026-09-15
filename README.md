# DeployMate — Automated Cloud Deployment & Monitoring Platform

DeployMate is a DevOps project that automates application deployment, cloud infrastructure provisioning, and application/server monitoring.

## Current Version

Version: 1.0.0

## Application

DeployMate is a simple Python Flask web application created as the application component of the DeployMate DevOps platform.

## Endpoints

### Home

```text
GET /
```

Returns basic application information.

### Health Check

```text
GET /health
```

Returns the current health status of the application.

### Version

```text
GET /version
```

Returns the current application version.

## Run Locally

Clone the repository:

```bash
git clone <repository-url>
cd deploymate
```

Create a virtual environment:

```bash
python3 -m venv venv
```

Activate it:

```bash
source venv/bin/activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Start the application:

```bash
python app.py
```

The application will run on:

```text
http://localhost:5000
```

Test the health endpoint:

```bash
curl http://localhost:5000/health
```

## Technology

* Python
* Flask
* Git
* GitHub

## Planned DevOps Components

* Docker
* Jenkins
* AWS EC2
* Terraform
* Prometheus
* Grafana
* Automated deployment
* Health checks
* Deployment rollback

## Project Goal

The final DeployMate platform will automatically build, test, containerize, deploy, monitor, and roll back the application through a complete CI/CD and cloud infrastructure workflow.

