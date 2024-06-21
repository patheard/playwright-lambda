# Playwright Lambda
Running Playwright in a Docker based Lambda function.

## Setup
```sh
# ./terraform
terraform -chdir=./terraform init
terraform -chdir=./terraform apply -target=aws_ecr_repository.playwright_lambda

$DOCKER_IMAGE="$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/playwright-lambda:latest"
docker build -t $DOCKER_IMAGE .
docker push $DOCKER_IMAGE

terraform -chdir=./terraform apply
```