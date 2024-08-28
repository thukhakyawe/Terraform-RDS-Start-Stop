resource "aws_cloudwatch_event_rule" "start_rds_rule" {
  name                = "start_rds_rule"
  schedule_expression = var.start_schedule
}

resource "aws_cloudwatch_event_rule" "stop_rds_rule" {
  name                = "stop_rds_rule"
  schedule_expression = var.stop_schedule
}

resource "aws_cloudwatch_event_target" "start_rds_lambda" {
  rule      = aws_cloudwatch_event_rule.start_rds_rule.name
  target_id = "start_rds_lambda"
  arn       = aws_lambda_function.rds_start_stop.arn

  input = jsonencode({
    action = "start"
  })
}

resource "aws_cloudwatch_event_target" "stop_rds_lambda" {
  rule      = aws_cloudwatch_event_rule.stop_rds_rule.name
  target_id = "stop_rds_lambda"
  arn       = aws_lambda_function.rds_start_stop.arn

  input = jsonencode({
    action = "stop"
  })
}

resource "aws_lambda_permission" "allow_cloudwatch_start" {
  statement_id  = "AllowExecutionFromCloudWatchStart"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rds_start_stop.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_rds_rule.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_stop" {
  statement_id  = "AllowExecutionFromCloudWatchStop"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rds_start_stop.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_rds_rule.arn
}
