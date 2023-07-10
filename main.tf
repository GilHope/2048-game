provider "aws" {
  region = "us-east-1"
}

resource "aws_elastic_beanstalk_application" "game_app" {
  name        = "2048-Game"
  description = "2048 Game Application"

  tags = {
    Demo = "2048"
  }
}

resource "aws_iam_role" "instance_role" {
  name = "elastic_beanstalk_instance_role"
  
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "eb_policy" {
  name = "Elastic_Beanstalk_Permissions"
  role = aws_iam_role.instance_role.id

  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:PutMetricData",
        "elasticbeanstalk:RetrieveEnvironmentInfo"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}



resource "aws_iam_instance_profile" "instance_profile" {
  name = "elastic_beanstalk_instance_profile"
  role = aws_iam_role.instance_role.name
}

resource "aws_elastic_beanstalk_environment" "game_env" {
  name                = "2048-Game-Environment"
  application         = aws_elastic_beanstalk_application.game_app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.5.9 running Docker"
  tier                = "WebServer"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro" 
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.instance_profile.name
  }

  tags = {
    Name = "2048-Game-Environment"
  }
}