terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>3.27"
        }
    }

    backend "s3" {
        bucket = "dzwcq2zr7yfy4mhz"
        key = "terraform-state/blog-api"
        region = "eu-west-2"
    }
    required_version = ">= 1.1.0"
}

variable "id" {
    type = string
    default = "hello-world"
    description = "Name of the deployment"
}

variable "availability_zone" {
    type = string
    default = "eu-west-2"
    description = "Which availability zone to use"
}

variable "vpc_cidr_block" {
    type = string
    default = "255.255.255.0/24"
    description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_block" {
    type = string
    default = "255.255.255.0/25"
    description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr_block" {
    type = string
    default = "255.255.255.128/25"
    description = "CIDR block for the private subnet"
}

provider "aws" {
    profile = "default"
    region = "eu-west-2"
}

module "lambda_vpc" {
    source = "./modules/lambda_vpc"
    id = var.id
    availability_zone = var.availability_zone
    vpc_cidr_block = var.vpc_cidr_block
    public_subnet_cidr_block = var.public_subnet_cidr_block
    private_subnet_cidr_block = var.private_subnet_cidr_block
}

resource "aws_vpc_endpoint" "s3" {
    vpc_id = module.lambda_vpc.vpc_id
    service_name = "com.amazonaws.${var.availability_zone}.s3"
    tags = {
        Name = "${var.id}-s3-vpc-endpoint"
    }
}
