# https://ropenscilabs.github.io/r-docker-tutorial/04-Dockerhub.html

.PHONY: build
build:
	docker build -t ringcentral/web-tools:12-alpine -f 12-alpine/Dockerfile .
	docker tag ringcentral/web-tools:12-alpine ringcentral/web-tools:alpine
	docker build -t ringcentral/web-tools:12-stretch -f 12-stretch/Dockerfile .
	docker tag ringcentral/web-tools:12-stretch ringcentral/web-tools:stretch
	docker tag ringcentral/web-tools:stretch ringcentral/web-tools:latest

.PHONY: start
start:
	docker run -d ringcentral/web-tools:alpine --name web-tools-alpine
	docker run -d ringcentral/web-tools:stretch --name web-tools-stretch

.PHONY: stop
stop:
	docker stop web-tools-alpine
	docker stop web-tools-stretch

.PHONY: push
push:
	docker push ringcentral/web-tools:12-alpine
	docker push ringcentral/web-tools:12-stretch
	docker push ringcentral/web-tools:alpine
	docker push ringcentral/web-tools:stretch
	docker push ringcentral/web-tools:latest

