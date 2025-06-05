resource "aws_cloudwatch_log_group" "cb_log_group" {
  name              = "/ecs/app1"
  retention_in_days = 30

  tags = {
    Name = "app-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "app-log-stream"
  log_group_name = aws_cloudwatch_log_group.cb_log_group.name
}

resource "aws_cloudwatch_log_group" "cb_log_group2" {
  name              = "/ecs/app2"
  retention_in_days = 30

  tags = {
    Name = "app-log-group-2"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream2" {
  name           = "app-log-stream-2"
  log_group_name = aws_cloudwatch_log_group.cb_log_group2.name
}