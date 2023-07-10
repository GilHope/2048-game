# 2048-Game

Welcome to the 2048 Game Application! This project provides a Dockerized version of the popular 2048 game, deployed on AWS Elastic Beanstalk using Terraform.

## Repository Structure

- `main.tf`: Contains Terraform configurations to setup AWS Elastic Beanstalk application and environment, IAM roles and policies, and necessary instance profile.
- `Dockerfile`: Dockerfile to build a Docker image for the 2048 game.
- `.github/workflows/main.yml`: GitHub Actions workflow for setting up, building, and deploying the game to Elastic Beanstalk.

## Prerequisites

- AWS Account
- GitHub Account
- Docker installed on local machine
- Terraform installed on local machine

## Setup

1. **Fork and clone the repository**

2. **Configure AWS Credentials**
   - Create an IAM user in AWS with sufficient permissions to create and manage AWS Elastic Beanstalk applications and environments.
   - Store the AWS Access Key ID and Secret Access Key of the IAM user in GitHub secrets with the names `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

3. **Configure Dockerfile**
   - Make sure the Dockerfile is correct and builds successfully on your local machine.

4. **Push Changes**
   - Make any changes necessary to the `main.tf` or `Dockerfile`.
   - Push the changes to the `main` branch of your forked repository.

## Dockerfile

The Dockerfile in this project sets up the game application with the following steps:
- It uses the Ubuntu 22.04 base image.
- Installs Nginx, zip, and curl packages.
- Configures Nginx to serve the 2048 game.
- Downloads the 2048 game source code from GitHub.
- Unzips and moves the game files to the appropriate location.
- Exposes port 80 for accessing the game.
- Starts Nginx as the main process.

## Terraform Configuration

The Terraform configuration in this project provisions the following AWS resources using the AWS Elastic Beanstalk service:
- Creates an Elastic Beanstalk application named "2048-Game" with a description.
- Defines an IAM role named "elastic_beanstalk_instance_role" that allows EC2 instances to assume the role.
- Creates an IAM instance profile named "elastic_beanstalk_instance_profile" associated with the instance role.
- Sets up an Elastic Beanstalk environment named "2048-Game-Environment" for hosting the game.
- Specifies the solution stack as "64bit Amazon Linux 2 v3.5.9 running Docker".
- Configures the environment with a "WebServer" tier, a "t2.micro" instance type, and a load-balanced environment type.
- Associates the IAM instance profile with the environment for proper permissions.
- Adds tags for easy identification of the resources.

## Workflow

The GitHub Actions workflow is triggered on every push to the `main` branch. Here's the breakdown of the steps:

1. Checkout the repository.
2. Configure AWS credentials using the secrets stored in GitHub.
3. Install and initialize Terraform.
4. Validate and plan the Terraform configuration.
5. Apply the Terraform configuration.
6. Create a deployment package from the repository.
7. Deploy the package to Elastic Beanstalk.

## Known Issues and Future Improvements

Currently, there is a known issue in whihc teh AWS Elastic Beanstalk environment gets stuck in a "Grey" state. This typically occurs when the environment does not return to a healthy state within a specified wait period after an update, which in in this project workflow is currently set to 300 seconds.

The root cause of this issue is yet to be determined and requires further investigation.

