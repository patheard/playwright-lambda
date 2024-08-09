AWS_ACCOUNT_ID := 123456789012
AWS_REGION := ca-central-1
DOCKER_DIR := .
TF_DIR := ./terraform

.PHONY: apply docker fmt init plan setup

apply: init
	cd ${TF_DIR} &&\
	terraform apply

docker:
	docker build \
		-t ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/playwright-lambda:latest \
		-f ${DOCKER_DIR}/Dockerfile ${DOCKER_DIR}
	aws ecr get-login-password --region ${AWS_REGION} | docker login \
		--username AWS \
		--password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
	docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/playwright-lambda:latest

fmt:
	@terraform fmt -recursive

init:
	cd ${TF_DIR} &&\
	terraform init

plan: init
	cd ${TF_DIR} &&\
	terraform plan

setup: init
	cd ${TF_DIR} &&\
	terraform apply \
		--target=aws_ecr_repository.playwright_lambda
	$(MAKE) docker
	$(MAKE) apply