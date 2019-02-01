provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "example" {
    ami = "ami-0e101c2ad1fbe6036"
    instance_type = "t2.micro"

    tags {
        Name = "terraform-example"
    }
}


