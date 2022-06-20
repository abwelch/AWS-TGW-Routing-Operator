# us-east-1 network config
resource "aws_vpc" "us-east-1" {
    provider = aws.us-east-1

    cidr_block = var.us-east-1_vpc-cidr
    tags = var.us-east-1_tags
}

resource "aws_subnet" "us-east-1" {
    provider = aws.us-east-1

    vpc_id = aws_vpc.us-east-1.id
    cidr_block = var.us-east-1_subnet-cidr
    tags = var.us-east-1_tags
}

resource "aws_route_table" "us-east-1" {
    provider = aws.us-east-1

    vpc_id = aws_vpc.us-east-1.id
    tags = var.us-east-1_tags
}

resource "aws_route" "us-east-1" {
    provider = aws.us-east-1

    route_table_id = aws_route_table.us-east-1.id
    destination_cidr_block = aws_vpc.us-west-1.cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.us-east-1.id
}

resource "aws_route_table_association" "us-east-1" {
    provider = aws.us-east-1

    subnet_id = aws_subnet.us-east-1.id
    route_table_id = aws_route_table.us-east-1.id
}

resource "aws_ec2_transit_gateway" "us-east-1" {
    provider = aws.us-east-1

    auto_accept_shared_attachments = "enable"
    default_route_table_propagation = "enable"
    default_route_table_association = "enable"
    tags = var.us-east-1_tags
}

resource "aws_ec2_transit_gateway_vpc_attachment" "us-east-1" {
    provider = aws.us-east-1

    subnet_ids = [aws_subnet.us-east-1.id]
    transit_gateway_id = aws_ec2_transit_gateway.us-east-1.id
    vpc_id = aws_vpc.us-east-1.id
    tags = var.us-east-1_tags
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "us-east-1" {
    provider = aws.us-east-1

    transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.us-west-1.id
    tags = var.us-east-1_tags
}
