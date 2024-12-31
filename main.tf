terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region     = var.awsRegion
  access_key = var.access_key
  secret_key = var.secret_key
}

data "aws_ami" "amzn_linux_2023_latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
      name = "name"
      values = [ "al2023-ami-2023*" ]
    }

    filter {
      name = "architecture"
      values = [ "x86_64" ]
    }
}

resource "aws_security_group" "backstage" {
  name        = "${var.instanceName}-backstage-sg"
  description = "Security group for Backstage EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instanceName}-backstage-sg"
  }
}

resource "aws_instance" "test_machine" {
  ami = data.aws_ami.amzn_linux_2023_latest.id
  instance_type = var.instanceType
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.backstage.id]
  key_name      = "backstage-key"

  tags = {
    Name = var.instanceName
  }
}
