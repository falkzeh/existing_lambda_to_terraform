provider "aws" {
  # assuming that you have your credentials setup in ~/.aws/credentials
  # otherwise use:
  #access_key = "ACCESS_KEY_HERE"
  #secret_key = "SECRET_KEY_HERE"
  region = "eu-west-1"
}

resource "aws_lambda_function" "terraform_lambda" {
  function_name = "terraform-managed-lambda"

  filename = "lambda.zip"

  handler = "lambda_function.lambda_handler"
  role    = "${aws_iam_role.iam_for_lambda.arn}"
  runtime = "python3.8"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = "${file("${path.module}/iam/lambda-assume-role-policy.json")}"

}
