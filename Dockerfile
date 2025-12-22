# Parameterized Web Tools Dockerfile
#
# Build example:
#   docker build \
#     --build-arg BASE_IMAGE_TAG=22.11.0-jdk21 \
#     --build-arg GRADLE_VERSION=8.5 \
#     --build-arg SONAR_VERSION=4.8.0.2856 \
#     --build-arg CX_FLOW_VERSION=1.7.11 \
#     --build-arg CX_FLOW_JAR=cx-flow.jar \
#     --build-arg SCA_RESOLVER_VERSION=2.12.36 \
#     -t ringcentral/web-tools:node22-jdk21 .

ARG BASE_IMAGE_TAG=22.11.0-jdk21

FROM ghcr.io/ringcentral-docker/node:${BASE_IMAGE_TAG}

LABEL maintainer="john.lin@ringcentral.com"

# Build arguments
ARG GRADLE_VERSION=8.5
ARG SONAR_VERSION=4.8.0.2856
ARG CX_FLOW_VERSION=1.7.11
ARG CX_FLOW_JAR=cx-flow.jar
ARG SCA_RESOLVER_VERSION=2.12.36

# Environment variables
ENV GRADLE_VERSION=${GRADLE_VERSION} \
    SONAR_VERSION=${SONAR_VERSION} \
    CX_FLOW_VERSION=${CX_FLOW_VERSION} \
    SCA_RESOLVER_VERSION=${SCA_RESOLVER_VERSION}

# Copy installation scripts
COPY scripts/ /tmp/scripts/
RUN chmod +x /tmp/scripts/*.sh

# Install base tools
RUN /tmp/scripts/install-base.sh

# Install Gradle
RUN /tmp/scripts/install-gradle.sh

# Install Puppeteer/Chromium dependencies
RUN /tmp/scripts/install-chromium.sh

# Install Sonar Scanner
RUN /tmp/scripts/install-sonar.sh

# Install Checkmarx tools
RUN /tmp/scripts/install-checkmarx.sh ${CX_FLOW_JAR}

# Cleanup
RUN rm -rf /tmp/scripts /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Final version summary
RUN echo "=== Final Version Summary ===" \
    && java -version \
    && javac -version \
    && mvn -version \
    && gradle --version \
    && node --version \
    && npm version \
    && yarn --version \
    && python3 --version \
    && git --version \
    && (command -v chromium && chromium --version --no-sandbox || echo "chromium: not installed") \
    && (command -v sonar-scanner && sonar-scanner --version || echo "sonar-scanner: not installed")
