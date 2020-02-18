FROM ringcentral/node:13.8.0-jdk13


# Puppeteer
# https://github.com/adrianchia/docker-node-puppeteer/blob/master/12/alpine/Dockerfile
# https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-on-alpine

ENV CHROME_BIN=/usr/bin/chromium-browser
RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      freetype-dev \
      harfbuzz \
      ca-certificates \
      ttf-freefont

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Sonar
# https://community.sonarsource.com/t/installing-sonar-scanner-in-alpine-linux-docker/7010

WORKDIR /opt
RUN apk add --no-cache unzip curl && \
    curl -s -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.1.0.1829-linux.zip -o sonar.zip && \
    unzip -qq sonar.zip && \
    rm sonar.zip && \
    ln -s /opt/sonar-scanner-4.1.0.1829-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /opt/sonar-scanner-4.1.0.1829-linux/bin/sonar-scanner && \
    sonar-scanner --version

# Git (needed for NPM install from Git)

RUN apk add --no-cache git

# Python (needed for NPM install Gyp)

RUN apk add --no-cache --virtual .gyp python make g++