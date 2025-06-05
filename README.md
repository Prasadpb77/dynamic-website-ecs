
# Dynamic Website Deployment on AWS ECS

This project demonstrates the deployment of a dynamic website using AWS services. The frontend is hosted on Amazon ECS, while the backend leverages AWS Lambda and DynamoDB. Infrastructure provisioning is managed through Terraform.

## 📁 Project Structure

```
dynamic-website-ecs/
├── IaC/                # Terraform configurations for AWS infrastructure
├── backend/            # AWS Lambda functions and related backend code
├── docker_images/      # Dockerfiles and resources for frontend containerization
├── .gitignore
└── README.md
```

## 🚀 Deployment Overview

- **Frontend**: Containerized application deployed on Amazon ECS.
- **Backend**: Serverless functions using AWS Lambda, interfacing with DynamoDB.
- **Infrastructure**: Provisioned and managed using Terraform scripts located in the `IaC/` directory.

## 🛠️ Prerequisites

- AWS Account with necessary permissions.
- Terraform installed on your local machine.
- Docker installed for building container images.
- AWS CLI configured with your credentials.

## 📦 Deployment Steps

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Prasadpb77/dynamic-website-ecs.git
   cd dynamic-website-ecs
   ```

2. **Build Docker Images**:
   Navigate to the `docker_images/` directory and build the frontend image.
   ```bash
   cd docker_images
   docker build -t your-frontend-image-name .
   ```

3. **Push Docker Image to AWS ECR**:
   Ensure you have an ECR repository created. Tag and push your image.
   ```bash
   aws ecr get-login-password --region your-region | docker login --username AWS --password-stdin your-account-id.dkr.ecr.your-region.amazonaws.com
   docker tag your-frontend-image-name:latest your-account-id.dkr.ecr.your-region.amazonaws.com/your-ecr-repo-name:latest
   docker push your-account-id.dkr.ecr.your-region.amazonaws.com/your-ecr-repo-name:latest
   ```

4. **Deploy Infrastructure with Terraform**:
   Navigate to the `IaC/` directory and initialize Terraform.
   ```bash
   cd ../IaC
   terraform init
   terraform apply
   ```
   Review the plan and confirm to proceed with the deployment.

5. **Deploy Backend Lambda Functions**:
   Navigate to the `backend/` directory and deploy your Lambda functions.
   This step may vary based on how the Lambda functions are configured (e.g., using AWS SAM, Serverless Framework, or manual deployment).

## 🔗 Accessing the Application

Once the deployment is complete, you can access the frontend application via the Load Balancer DNS provided by ECS. The backend APIs are accessible through the API Gateway endpoints configured during the Lambda deployment.

## 📚 Resources

- [Amazon ECS Documentation](https://docs.aws.amazon.com/ecs/)
- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/)
- [Amazon DynamoDB Documentation](https://docs.aws.amazon.com/dynamodb/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
