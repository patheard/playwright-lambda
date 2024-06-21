module "playwright_lambda" {
  source = "github.com/cds-snc/terraform-modules//lambda?ref=v9.5.0"

  name      = "playwright-lambda"
  ecr_arn   = aws_ecr_repository.playwright_lambda.arn
  image_uri = "${aws_ecr_repository.playwright_lambda.repository_url}:latest"
  memory    = 2048
  timeout   = 300

  billing_tag_value = "sre"
}

resource "aws_ecr_repository" "playwright_lambda" {
  name                 = "playwright-lambda"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    CostCentre = "sre"
    Terraform  = true
  }
}