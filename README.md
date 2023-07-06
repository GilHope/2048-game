# 2048-Game

Welcome to the 2048 Game Application! This project provides a Dockerized version of the popular 2048 game, deployed on AWS Elastic Beanstalk using Terraform.

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