provider "aws" {
    region = "eu-west-1"
}

variable "server_port" { default = 80 }

resource "aws_instance" "example" {
    ami = "ami-0e101c2ad1fbe6036"
    instance_type = "t2.micro"

    security_groups = ["${aws_security_group.instance.id}"]

    tags {
        Name = "terraform-example"
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_security_group" "instance" {

    name = "terraform-example-instance"

    ingress {
        from_port = "${var.server_port}"
        to_port = "${var.server_port}"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    lifecycle {
        create_before_destroy = true
    }
}



