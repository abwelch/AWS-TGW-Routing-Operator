# us-west-1 network config
resource "aws_vpc" "us-west-1" {
    provider = aws.us-west-1

    cidr_block = var.us-west-1_vpc-cidr
    tags = var.us-west-1_tags
}

resource "aws_subnet" "us-west-1" {
    provider = aws.us-west-1

    vpc_id = aws_vpc.us-west-1.id
    cidr_block = var.us-west-1_subnet-cidr
    tags = var.us-west-1_tags
}

resource "aws_route_table" "us-west-1" {
    provider = aws.us-west-1

    vpc_id = aws_vpc.us-west-1.id
    tags = var.us-west-1_tags
}

resource "aws_route" "us-west-1" {
    provider = aws.us-west-1

    route_table_id = aws_route_table.us-west-1.id
    destination_cidr_block = aws_vpc.us-east-1.cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.us-west-1.id
}

resource "aws_route_table_association" "us-west-1" {
    provider = aws.us-west-1

    subnet_id = aws_subnet.us-west-1.id
    route_table_id = aws_route_table.us-west-1.id
}

resource "aws_ec2_transit_gateway" "us-west-1" {
    provider = aws.us-west-1

    auto_accept_shared_attachments = "enable"
    default_route_table_propagation = "enable"
    default_route_table_association = "enable"
    tags = var.us-west-1_tags
}

resource "aws_ec2_transit_gateway_vpc_attachment" "us-west-1" {
    provider = aws.us-west-1

    subnet_ids = [aws_subnet.us-west-1.id]
    transit_gateway_id = aws_ec2_transit_gateway.us-west-1.id
    vpc_id = aws_vpc.us-west-1.id
    tags = var.us-west-1_tags
}

data "aws_caller_identity" "us-west-1" {
    provider = aws.us-west-1
}

resource "aws_ec2_transit_gateway_peering_attachment" "us-west-1" {
    provider = aws.us-west-1

    peer_account_id = data.aws_caller_identity.us-west-1.account_id
    peer_region = "us-east-1"
    transit_gateway_id = aws_ec2_transit_gateway.us-west-1.id
    peer_transit_gateway_id = aws_ec2_transit_gateway.us-east-1.id
    tags = var.us-west-1_tags
}
