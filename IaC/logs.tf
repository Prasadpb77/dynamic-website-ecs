resource "aws_cloudwatch_log_group" "cb_log_group" {
  name              = "/ecs/app"
  retention_in_days = 30

  tags = {
    Name = "app-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "app-log-stream"
  log_group_name = aws_cloudwatch_log_group.cb_log_group.name
}