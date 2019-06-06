resource "aws_lb" "external_alb" {
  name               = "${var.project_name}-External-ALB"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["${aws_subnet.inbound_subnet.*.id}"]

  tags = {
    name               = "${var.project_name}-External-ALB"
  }
}

resource "aws_lb_listener" "external_alb_listener" {
  load_balancer_arn = "${aws_lb.external_alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.external_lb_tg_app1.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "external_lb_tg_app1" {
  name = "${var.project_name}-Ext-ALB-TG-app1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.inbound_vpc.id}"
  tags {
    name = "${var.project_name}-Ext-ALB-TG-app1"
  }
}

resource "aws_lb_target_group" "external_lb_tg_app2" {
  name = "${var.project_name}-Ext-ALB-TG-app2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.inbound_vpc.id}"
  tags {
    name = "${var.project_name}-Ext-ALB-TG-app2"
  }
}

resource "aws_lb_listener_rule" "external_alb_rules" {
  listener_arn = "${aws_lb_listener.external_alb_listener.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.external_lb_tg_app1.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/app1/*"]
  }

  priority     = 90

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.external_lb_tg_app2.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/app2/*"]
  }
}
/*
resource "aws_lb_target_group_attachment" "external_alb_target_group_attachment_app2" {
  count            = "${aws_instance.spoke_1a_instance.count}"
  target_group_arn = "${aws_lb_target_group.internal_lb_target_group_app2.arn}"
  target_id        = "${element(aws_instance.spoke_1a_instance.*.id, count.index)}"
  port             = ${var.app_1_high_port}
}
*/

/*
# Deploy external ALB
resource "aws_lb" "external_alb" {
  name               = "${var.project_name}-External-ALB"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["${aws_subnet.inbound_subnet.*.id}"]

  tags = {
    name               = "${var.project_name}-External-ALB"
  }
}  

resource "aws_lb_listener" "external_alb_listener" {  
  load_balancer_arn = "${aws_lb.external_alb.arn}"  
  port              = 80  
  protocol          = "HTTP"
  
  default_action {    
    target_group_arn = "${aws_lb_target_group.external_lb_tg_app1.arn}"
    type             = "forward"  
  }
} 

resource "aws_lb_target_group" "external_lb_tg_app1" {   
  name = "${var.project_name}-Ext-ALB-TG-app1" 
  port     = "${var.app_1_high_port}"  
  protocol = "HTTP"  
  vpc_id   = "${aws_vpc.inbound_vpc.id}"   
  tags {    
    name = "${var.project_name}-Ext-ALB-TG-app1"    
  }     
} 

resource "aws_lb_target_group" "external_lb_tg_app2" {   
  name = "${var.project_name}-Ext-ALB-TG-app2" 
  port     = "${var.app_2_high_port}"  
  protocol = "HTTP"  
  vpc_id   = "${aws_vpc.inbound_vpc.id}"   
  tags {    
    name = "${var.project_name}-Ext-ALB-TG-app2"    
  }     
} 
 
resource "aws_lb_listener_rule" "external_alb_rules" {
  listener_arn = "${aws_lb_listener.external_alb_listener.arn}"

  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.external_lb_tg_app1.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/app1/*"]
  }

  priority     = 90

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.external_lb_tg_app2.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/app2/*"]
  }
}
*/
/*
resource "aws_lb_target_group_attachment" "external_alb_target_group_attachment_app2" {
  count            = "${aws_instance.spoke_1a_instance.count}"
  target_group_arn = "${aws_lb_target_group.internal_lb_target_group_app2.arn}"
  target_id        = "${element(aws_instance.spoke_1a_instance.*.id, count.index)}"
  port             = 9081
}
*/