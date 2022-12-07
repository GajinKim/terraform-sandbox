terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 4.16"
}
}
required_version = ">= 1.2.0"
}
provider "aws" {
region = "us-east-1"
}
resource "aws_s3_bucket" "my_bucket" {
bucket = "wwl-gajin-bucket"
tags = {
Name = "My Bucket",
Owner = "Gajin",
Environment = "Test"
}
}
resource "aws_s3_bucket_acl" "my_bucket_acl" {
bucket = aws_s3_bucket.my_bucket.id
acl = "private"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "gajin_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "Gajin's ec2 instance"
    Created_By = "Gajin Kim"
  }
}