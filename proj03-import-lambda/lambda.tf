import {
  to = aws_lambda_function.this
  id = "manually-create-lambda"
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.root}/build/index.mjs"
  output_path = "${path.root}/lambda.zip"
}

resource "aws_lambda_function" "this" {
  description      = "A starter AWS Lambda function."
  filename         = "lambda.zip"
  function_name    = "manually-create-lambda"
  handler          = "index.handler"
  role             = aws_iam_role.lambda_execution_role.arn
#   role             = "arn:aws:iam::728581607850:role/service-role/manually-create-lambda-role-b4lxte96"
  runtime          = "nodejs22.x"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  tags = {
    "lambda-console:blueprint" = "hello-world"
  }
  logging_config {
    application_log_level = null
    log_format            = "Text"
    log_group             = "/aws/lambda/manually-create-lambda"
    system_log_level      = null
  }
}
