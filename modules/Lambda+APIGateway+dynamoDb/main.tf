provider "aws" {
  region = var.region
}

# Rôle IAM pour Lambda
resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.lambda_execution_role_name}_${random_id.role_suffix.hex}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "random_id" "role_suffix" {
  byte_length = 4
}

# Attachement de la politique IAM pour permettre l'accès à DynamoDB
resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "lambda_dynamodb_policy"
  description = "Politique permettant l'accès à DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Resource = aws_dynamodb_table.my_table.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_attach" {
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}

# Création de la table DynamoDB
resource "aws_dynamodb_table" "my_table" {
  name         = "ticket-generator-dynamodb-prod"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# Générer le fichier Lambda (index.js) à partir du code source en Terraform
resource "local_file" "lambda_code" {
  content  = <<EOF
const AWS = require("aws-sdk");
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    const params = {
        TableName: "ticket-generator-dynamodb-prod",
        Item: {
            id: "1234",
            message: "Hello from Lambda and DynamoDB!"
        }
    };
    await dynamoDB.put(params).promise();
    return {
        statusCode: 200,
        body: JSON.stringify({ message: "Data inserted into DynamoDB" })
    };
};
EOF
  filename = "${path.module}/index.js"
}

# Zipper le code Lambda pour le déployer
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = local_file.lambda_code.filename
  output_path = "${path.module}/lambda_function.zip"
}

# Fonction Lambda avec le code zipé
resource "aws_lambda_function" "my_lambda" {
  function_name = var.lambda_function_name
  runtime       = "nodejs22.x"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "index.handler"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# API Gateway
resource "aws_api_gateway_rest_api" "my_api" {
  name        = var.api_gateway_name
  description = "API Gateway pour Lambda"
}

# Ressource API Gateway
resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "resource"
}

# Méthode GET sur l'API Gateway
resource "aws_api_gateway_method" "my_method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Intégration API Gateway avec Lambda
resource "aws_api_gateway_integration" "my_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.my_resource.id
  http_method             = aws_api_gateway_method.my_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.my_lambda.arn}/invocations"
}

# Autorisation API Gateway pour invoquer Lambda
resource "aws_lambda_permission" "allow_api_gateway" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "apigateway.amazonaws.com"
}

# Déploiement de l'API Gateway
resource "aws_api_gateway_deployment" "my_deployment" {
  depends_on = [
    aws_api_gateway_integration.my_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.my_api.id
}

