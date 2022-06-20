terraform {
    backend "s3" {
        bucket = "tgw-operator-tf-state"
        key = "terraform-state"
        region = "us-east-1"
    }
}