terraform {
    backend "s3" {
        bucket = "deploy-terraform-laravel-state"
        key    = "assets/dev/services/cluster/terraform.tfstate"
        region = "eu-west-1"
    }
}

provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "example" {

    ami = "ami-0e101c2ad1fbe6036"
    instance_type = "t2.micro"

    vpc_security_group_ids = ["${aws_security_group.instance.id}"]

    user_data = "${file("user_data.sh")}"

    tags {
        Name = "${var.cluster_name}"
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_security_group" "instance" {
    name = "${var.cluster_name}-instance"
}

resource "aws_security_group_rule" "allow_http_inbound" {

    type = "ingress"

    security_group_id = "${aws_security_group.instance.id}"

    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "allow_all_outbound" {

    type = "egress"

    security_group_id = "${aws_security_group.instance.id}"

    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

}

