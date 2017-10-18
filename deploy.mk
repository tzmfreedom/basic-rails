REPO_NAME = xxxx.dkr.ecr.ap-northeast-1.amazonaws.com/tzmfreedom/repo:latest
CLUSTER_NAME = hoge
SERVICE_NAME = rails

.PHONY: deploy
deploy:
	eval "$(shell aws ecr get-login --no-include-email --region ap-northeast-1)"
	docker build -t $(REPO_NAME) .
	docker push $(REPO_NAME)
	ecs-deploy -c $(CLUSTER_NAME) -n $(SERVICE_NAME) -i $(REPO_NAME)
