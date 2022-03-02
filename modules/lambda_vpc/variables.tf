variable "id" {
    type = string
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
