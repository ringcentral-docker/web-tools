# https://ropenscilabs.github.io/r-docker-tutorial/04-Dockerhub.html

.PHONY: build
build:
	docker build -t ringcentral/web-tools:alpine -f alpine/Dockerfile .
	docker build -t ringcentral/web-tools:stretch -f stretch/Dockerfile .
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
	docker push ringcentral/web-tools:alpine
	docker push ringcentral/web-tools:latest
	docker push ringcentral/web-tools:stretch

