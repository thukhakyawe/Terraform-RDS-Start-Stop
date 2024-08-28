output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.rds_start_stop.arn
}

output "start_rds_rule_arn" {
  description = "ARN of the CloudWatch rule for starting RDS instances"
  value       = aws_cloudwatch_event_rule.start_rds_rule.arn
}

output "stop_rds_rule_arn" {
  description = "ARN of the CloudWatch rule for stopping RDS instances"
  value       = aws_cloudwatch_event_rule.stop_rds_rule.arn
}
