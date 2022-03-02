resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.id}-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr_block
    tags = {
        Name = "${var.id}-public-subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.id}-igw"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.id}-public-route-table"
    }
}

resource "aws_route_table_association" "public_route_table_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr_block

    tags = {
        Name = "${var.id}-private-subnet"
    }
}

resource "aws_eip" "ip" {
    vpc = true
    
    tags = {
        Name = "${var.id}-elastic-ip"
    }
}

resource "aws_nat_gateway" "gateway" {
    subnet_id = aws_subnet.public_subnet.id
    allocation_id = aws_eip.ip.allocation_id

    depends_on = [
      aws_internet_gateway.igw
    ]

    tags = {
        Name = "${var.id}-nat-gateway"
    }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gateway.id
    }

    tags = {
        Name = "${var.id}-private-route-table"
    }
}

resource "aws_route_table_association" "private_route_table_association" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_route_table.id
}
