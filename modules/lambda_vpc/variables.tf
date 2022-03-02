variable "id" {
    type = string
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
