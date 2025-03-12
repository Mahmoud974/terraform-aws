provider "aws" {
  region = "eu-west-3"
}

# Créer un rôle IAM pour Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

# Créer une fonction Lambda
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_s3_lambda"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"

  # Utilisez le chemin du fichier ZIP de votre code Lambda
  filename = "index.js.gz"

  environment {
    variables = {

    }
  }
}

# Créer une API Gateway pour invoquer la fonction Lambda
resource "aws_api_gateway_rest_api" "my_api" {
  name        = "my_lambda_api"
  description = "API Gateway for Lambda"
}

# Créer une ressource API Gateway
resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "hello"
}

# Créer une méthode GET pour l'API Gateway
resource "aws_api_gateway_method" "my_method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Intégration de l'API Gateway avec Lambda
resource "aws_api_gateway_integration" "my_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.my_resource.id
  http_method             = aws_api_gateway_method.my_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.my_lambda.arn}/invocations"
}

# Autoriser l'API Gateway à invoquer la fonction Lambda
resource "aws_lambda_permission" "allow_api_gateway" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  statement_id  = "AllowExecutionFromAPIGateway"
}
