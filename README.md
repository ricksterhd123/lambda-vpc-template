# Lambda VPC terraform module
Creates a VPC that routes all traffic from a private subnet through a NAT gateway (with an Elastic IP attached) before entering an internet gateway.

This VPC is designed to be used by multiple lambda functions so that they can communicate on the internet using a static IP. One specific use-case is when you need to connect to an API that has a strict firewall and only allows access by whitelisting an IP.

Not sure if CIDR blocks make any sense, they can be configured using https://cidr.xyz/
