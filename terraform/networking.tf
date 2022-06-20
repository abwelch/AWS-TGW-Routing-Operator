resource "aws_vpc" "us-east-1" {
    cidr_block = var.us-east-1-cidr
    tags = {
        Name = "primary"
        Region = "us-east-1"
    }
}