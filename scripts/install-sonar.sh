#!/bin/bash
set -e

echo "Installing Sonar Scanner ${SONAR_VERSION}..."

# Detect architecture
ARCH=$(dpkg --print-architecture)
case "${ARCH}" in
    amd64) SONAR_ARCH="linux-x64" ;;
    arm64) SONAR_ARCH="linux-aarch64" ;;
    *) echo "Unsupported architecture: ${ARCH}" && exit 1 ;;
esac

echo "  Architecture: ${ARCH} -> ${SONAR_ARCH}"

cd /opt
curl -sL "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_VERSION}-${SONAR_ARCH}.zip" -o sonar.zip \
    && unzip -q sonar.zip \
    && rm sonar.zip \
    && ln -s /opt/sonar-scanner-${SONAR_VERSION}-${SONAR_ARCH}/bin/sonar-scanner /usr/local/bin/sonar-scanner \
    && sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /opt/sonar-scanner-${SONAR_VERSION}-${SONAR_ARCH}/bin/sonar-scanner

# Verify installation
echo "=== Verifying Sonar Scanner ==="
sonar-scanner --version

echo "Sonar Scanner ${SONAR_VERSION} installed successfully."
