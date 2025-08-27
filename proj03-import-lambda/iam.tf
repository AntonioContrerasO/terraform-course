import {
  to = aws_iam_role.lambda_execution_role
  id = "manually-create-lambda-role-b4lxte96"
}

import {
  to = aws_iam_policy.lambda_execution
  id = "arn:aws:iam::728581607850:policy/service-role/AWSLambdaBasicExecutionRole-2fba1670-426f-4ce4-94f3-ca2f78523324"
}

resource "aws_iam_policy" "lambda_execution" {
  name        = "AWSLambdaBasicExecutionRole-2fba1670-426f-4ce4-94f3-ca2f78523324"
  path        = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = "logs:CreateLogGroup"
      Effect   = "Allow"
      Resource = "arn:aws:logs:us-west-1:728581607850:*"
      }, {
      Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:us-west-1:728581607850:log-group:/aws/lambda/manually-create-lambda:*"]
    }]
    Version = "2012-10-17"
  })
}


resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  name                  = "manually-create-lambda-role-b4lxte96"
  path                  = "/service-role/"
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role = aws_iam_role.lambda_execution_role.id
  policy_arn = aws_iam_policy.lambda_execution.arn
}



