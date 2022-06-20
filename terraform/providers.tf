provider "aws" {
    alias = "us-east-1"
    region = "us-east-1"
    shared_config_files = ["/Users/drew/.aws/config"]
    shared_credentials_files = ["/Users/drew/.aws/credentials"]
}

provider "aws" {
    alias = "us-west-1"
    region = "us-west-1"
    shared_config_files = ["/Users/drew/.aws/config"]
    shared_credentials_files = ["/Users/drew/.aws/credentials"]
}
