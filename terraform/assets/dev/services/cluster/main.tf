provider "aws" {
    region = "eu-west-1"
}

variable "server_port" { default = 80 }

resource "aws_instance" "example" {
    ami = "ami-0e101c2ad1fbe6036"
    instance_type = "t2.micro"

    vpc_security_group_ids = ["sg-05fdb3e471325ce6a"]

    tags {
        Name = "terraform-example"
    }

    lifecycle {
        create_before_destroy = true
    }
}



