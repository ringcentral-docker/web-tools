FROM node:18.13.0-alpine

# OpenJDK
ENV JAVA_HOME="/usr/lib/jvm/default-jvm"
ENV OPENJDK_VERSION=8

RUN apk update \
      && apk add --no-cache openjdk${OPENJDK_VERSION} \
      && rm -rf /var/cache/apk/*

# Has to be set explictly to find binaries 
ENV PATH="$PATH:${JAVA_HOME}/bin"

# Required libraries
RUN apk add --no-cache git unzip curl && \
      rm -rf /var/cache/apk/*

# Maven
RUN apk update \
      && apk add --no-cache maven \
      && rm -rf /var/cache/apk/*

# Gradle
WORKDIR /opt

ENV GRADLE_VERSION=7.6

RUN curl -sL https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip > gradle.zip && \
      unzip gradle.zip && \
      rm gradle.zip && \
      rm -rf /var/cache/apk/*

ENV PATH="$PATH:/opt/gradle-${GRADLE_VERSION}/bin"
      
# Mercurial
RUN apk update \
      && apk add --no-cache mercurial \
      && rm -rf /var/cache/apk/*  
      
# rng-tools for FED Project
RUN apk update \
      && apk add --no-cache rng-tools \
      && rm -rf /var/cache/apk/*
      
# bash for MAA project
RUN apk update \
      && apk add --no-cache bash openssh \
      && rm -rf /var/cache/apk/*

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV CHROME_BIN=/usr/bin/chromium-browser \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Puppeteer
# https://github.com/adrianchia/docker-node-puppeteer/blob/master/12/alpine/Dockerfile
# https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-on-alpine

RUN apk update \
      && apk add --no-cache \
            chromium \ 
            nss \
            freetype \
            freetype-dev \
            harfbuzz \
            ca-certificates \
            ttf-freefont \
      && rm -rf /var/cache/apk/*

# Sonar
# https://community.sonarsource.com/t/installing-sonar-scanner-in-alpine-linux-docker/7010

RUN curl -sL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip -o sonar.zip && \
      unzip -qq sonar.zip && \
      rm sonar.zip && \
      ln -s /opt/sonar-scanner-4.6.2.2472-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
      sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /opt/sonar-scanner-4.6.2.2472-linux/bin/sonar-scanner && \
      sonar-scanner --version

# Python (needed for NPM install Gyp)

RUN apk add --no-cache --virtual .gyp python3 make g++

# Checkmarx tools for Java 8
ENV CX_FLOW_VERSION=1.6.39 SCA_RESOLVER_VERSION=1.15.6

RUN mkdir cx-flow && \
      curl -sL https://github.com/checkmarx-ltd/cx-flow/releases/download/${CX_FLOW_VERSION}/cx-flow-${CX_FLOW_VERSION}.jar > ./cx-flow/cx-flow.jar

RUN mkdir sca-resolver && \
      curl -sL "https://sca-downloads.s3.amazonaws.com/cli/${SCA_RESOLVER_VERSION}/ScaResolver-musl64.tar.gz" > ./sca-resolver/ScaResolver.tar.gz && \
      tar -vxzf ./sca-resolver/ScaResolver.tar.gz -C ./sca-resolver && \
      rm ./sca-resolver/ScaResolver.tar.gz

#==============
# Show version
#==============
RUN java -version \
    && javac -version \
    && mvn -version \
    && node --version \
    && npm version \
    && yarn --version \
    && python3 --version
