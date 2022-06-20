# us-east-1
variable "us-east-1_vpc-cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "us-east-1_subnet-cidr" {
    type = string
    default = "10.0.0.0/24"
}

variable "us-east-1_tags" {
    type = object({
        Name = string
        Region = string
    })
    default = {
        Name = "primary"
        Region = "us-east-1"
    }
}

# us-west-1
variable "us-west-1_vpc-cidr" {
    type = string
    default = "10.1.0.0/16"
}

variable "us-west-1_subnet-cidr" {
    type = string
    default = "10.1.0.0/24"
}

variable "us-west-1_tags" {
    type = object({
        Name = string
        Region = string
    })
    default = {
        Name = "secondary"
        Region = "us-west-1"
    }
}
