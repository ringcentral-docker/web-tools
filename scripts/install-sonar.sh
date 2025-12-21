#!/bin/bash
set -e

echo "Installing Sonar Scanner ${SONAR_VERSION}..."

# Detect architecture
ARCH=$(dpkg --print-architecture)

# Determine version major (e.g., 4.8.0.2856 -> 4)
VERSION_MAJOR=$(echo "${SONAR_VERSION}" | cut -d. -f1)

# Sonar Scanner 5.x+ uses linux-x64/linux-aarch64, older versions use just "linux"
if [[ "${VERSION_MAJOR}" -ge 5 ]]; then
    case "${ARCH}" in
        amd64) SONAR_ARCH="linux-x64" ;;
        arm64) SONAR_ARCH="linux-aarch64" ;;
        *) echo "Unsupported architecture: ${ARCH}" && exit 1 ;;
    esac
else
    # Older versions (4.x) only support x64 with "linux" suffix
    if [[ "${ARCH}" == "arm64" ]]; then
        echo "WARNING: Sonar Scanner ${SONAR_VERSION} does not support arm64, skipping installation."
        echo "=== Sonar Scanner skipped (no arm64 support) ==="
        exit 0
    fi
    SONAR_ARCH="linux"
fi

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
