resource "aws_ecs_cluster" "main" {
  name = "app-cluster"
}


resource "aws_ecs_task_definition" "app" {
  family                   = "app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions = jsonencode([
    {
      name        = "frontend"
      image       = "920013188018.dkr.ecr.us-west-1.amazonaws.com/ecs-image/frontend"
      cpu         = 1024
      memory      = 2048
      networkMode = "awsvpc"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          awslogs-group : "/ecs/app1",
          awslogs-region : "us-west-1"
          awslogs-stream-prefix : "ecs"
        }
      },
  }])
}


resource "aws_ecs_task_definition" "app2" {
  family                   = "app-task2"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions = jsonencode([
    {
      name        = "dashboard"
      image       = "920013188018.dkr.ecr.us-west-1.amazonaws.com/ecs-image/dashboard"
      cpu         = 1024
      memory      = 2048
      networkMode = "awsvpc"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          awslogs-group : "/ecs/app2",
          awslogs-region : "us-west-1"
          awslogs-stream-prefix : "ecs"
        }
      },
  }])
}

resource "aws_ecs_service" "main" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = [var.private_subnet, var.public_subnet]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "frontend"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_policy_attachment.ecs_task_execution_policy_attachment]
}

resource "aws_ecs_service" "main2" {
  name            = "app-service-2"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app2.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = [var.private_subnet, var.public_subnet]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app2.id
    container_name   = "dashboard"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.dashboard, aws_iam_policy_attachment.ecs_task_execution_policy_attachment]
}