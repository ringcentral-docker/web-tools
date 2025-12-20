#!/bin/bash
set -e

echo "Installing Gradle ${GRADLE_VERSION}..."

cd /opt
curl -sL "https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o gradle.zip \
    && unzip -q gradle.zip \
    && rm gradle.zip \
    && ln -s /opt/gradle-${GRADLE_VERSION}/bin/gradle /usr/local/bin/gradle

# Verify installation
echo "=== Verifying Gradle ==="
gradle --version

echo "Gradle ${GRADLE_VERSION} installed successfully."
