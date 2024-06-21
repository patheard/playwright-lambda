# Playwright Lambda
Running Playwright in a Docker based Lambda function.

## Setup
```sh
# Create ECR
terraform -chdir=./terraform init
terraform -chdir=./terraform apply -target=aws_ecr_repository.playwright_lambda

# Build and push Docker image
$DOCKER_IMAGE="$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/playwright-lambda:latest"
docker build -t $DOCKER_IMAGE .
docker push $DOCKER_IMAGE

# Create Lambda
terraform -chdir=./terraform apply
```