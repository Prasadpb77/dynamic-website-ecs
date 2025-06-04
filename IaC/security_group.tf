# security.tf

# ALB security Group: Edit to restrict access to the application
resource "aws_security_group" "lb" {
    name        = "app-load-balancer-security-group"
    description = "controls access to the ALB"
    vpc_id      = var.vpc_id

    ingress {
        protocol    = "tcp"
        from_port   = var.app_port
        to_port     = var.app_port
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks" {
    name        = "app-ecs-tasks-security-group"
    description = "allow inbound access from the ALB only"
    vpc_id      = var.vpc_id

    ingress {
        protocol        = "tcp"
        from_port       = var.app_port
        to_port         = var.app_port
        security_groups = [aws_security_group.lb.id]
    }

    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_iam_role" "ecs_task_execution_role" {
    name = "ecs_task_execution_role"
    assume_role_policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    })
}

resource "aws_iam_policy_attachment" "ecs_task_execution_policy_attachment" {
  name = "ecs_task_execution_policy_attachment"
  roles = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly" 
}