output "vpc_id" {
    value = aws_vpc.main.id
    description = "Id of VPC in which these resources exist"
}

output "private_subnet_arn" {
    value = aws_subnet.private_subnet.arn
    description = "ARN of private subnet"
}

output "public_subnet_arn" {
    value = aws_subnet.public_subnet.arn
    description = "ARN of public subnet"
}

output "eip_allocation_id" {
    value = aws_eip.ip.allocation_id
    description = "Allocation id of Elastic IP"
}
