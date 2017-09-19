resource "aws_security_group" "k8s_inbound_ssh" {
    name = "${var.env}_inbound_ssh"
    vpc_id = "${var.vpc_id}"

    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      security_groups = [
        "${var.inbound_ssh_source_sg_id}"
      ]
    }
}

resource "aws_security_group" "k8s_inbound_http" {
    name = "${var.env}_inbound_http"
    vpc_id = "${var.vpc_id}"

    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["${var.inbound_http_cidr_blocks}"]
    }

    ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["${var.inbound_http_cidr_blocks}"]
    }
}


resource "aws_security_group" "k8s_nodes_extra" {
    name = "${var.env}_nodes_extra"
    vpc_id = "${var.vpc_id}"

    tags {
      Name = "${var.env}_nodes_extra"
    }
}

resource "aws_security_group_rule" "app_ingress_inbound_http" {
  type            = "ingress"

  from_port       = "${var.inbound_app_ingress_http_port}"
  to_port         = "${var.inbound_app_ingress_http_port}"
  protocol        = "tcp"
  source_security_group_id = "${var.app_ingress_source_sg_id}"

  security_group_id = "${aws_security_group.k8s_nodes_extra.id}"
}

resource "aws_security_group_rule" "app_ingress_inbound_https" {
  type            = "ingress"

  from_port       = "${var.inbound_app_ingress_https_port}"
  to_port         = "${var.inbound_app_ingress_https_port}"
  protocol        = "tcp"
  source_security_group_id = "${var.app_ingress_source_sg_id}"

  security_group_id = "${aws_security_group.k8s_nodes_extra.id}"
}


resource "aws_security_group" "k8s_masters_extra" {
    name = "${var.env}_masters_extra"
    vpc_id = "${var.vpc_id}"

    tags {
      Name = "${var.env}_masters_extra"
    }
}
