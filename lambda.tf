resource "aws_lambda_function" "rds_start_stop" {
  function_name = "RDSStartStopFunction"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "lambda_function.handler"
  runtime       = "python3.12"

  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  environment {
    variables = {
      # Add environment variables here if needed
    }
  }
}
