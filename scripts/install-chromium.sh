#!/bin/bash
set -e

echo "Installing Chromium and Puppeteer dependencies..."

# Detect architecture
ARCH=$(dpkg --print-architecture)

# Install common dependencies for Puppeteer
apt-get update && apt-get install -y --no-install-recommends \
    fonts-liberation \
    fonts-dejavu-core \
    libgbm1 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2t64 \
    libxshmfence1 \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

if [[ "${ARCH}" == "amd64" ]]; then
    echo "Downloading Chromium from official snapshots..."

    # Get latest version
    CHROMIUM_VERSION=$(curl -s "https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media")
    echo "  Latest version: ${CHROMIUM_VERSION}"

    # Download and extract
    cd /opt
    curl -sL "https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F${CHROMIUM_VERSION}%2Fchrome-linux.zip?alt=media" -o chromium.zip
    unzip -q chromium.zip
    rm chromium.zip

    # Create symlink
    ln -s /opt/chrome-linux/chrome /usr/local/bin/chromium

    CHROMIUM_BIN="/usr/local/bin/chromium"
else
    echo "WARNING: Chromium official builds not available for ${ARCH}, skipping..."
    echo "  Puppeteer will need to download its own Chromium or use a custom executable."

    # Set empty path - Puppeteer will handle this
    CHROMIUM_BIN=""
fi

# Set Puppeteer environment variables
if [[ -n "${CHROMIUM_BIN}" ]]; then
    echo "export CHROME_BIN=${CHROMIUM_BIN}" >> /etc/profile.d/chromium.sh
    echo "export PUPPETEER_EXECUTABLE_PATH=${CHROMIUM_BIN}" >> /etc/profile.d/chromium.sh
fi
echo 'export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true' >> /etc/profile.d/chromium.sh
chmod +x /etc/profile.d/chromium.sh

# Verify installation
echo "=== Verifying Chromium ==="
if [[ -n "${CHROMIUM_BIN}" && -x "${CHROMIUM_BIN}" ]]; then
    ${CHROMIUM_BIN} --version --no-sandbox
else
    echo "Chromium not installed on this architecture (${ARCH})"
fi

echo "Chromium installation completed."
