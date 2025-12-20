#!/bin/bash
set -e

echo "Installing Chromium and Puppeteer dependencies..."

# Install Chromium and dependencies for Puppeteer
# Note: Package names vary between Ubuntu versions
apt-get update && apt-get install -y --no-install-recommends \
    chromium-browser \
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
    && rm -rf /var/lib/apt/lists/*

# Find chromium binary path
CHROMIUM_BIN=$(which chromium-browser || which chromium || echo "/usr/bin/chromium-browser")

# Set Puppeteer environment variables
echo "export CHROME_BIN=${CHROMIUM_BIN}" >> /etc/profile.d/chromium.sh
echo "export PUPPETEER_EXECUTABLE_PATH=${CHROMIUM_BIN}" >> /etc/profile.d/chromium.sh
echo 'export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true' >> /etc/profile.d/chromium.sh
chmod +x /etc/profile.d/chromium.sh

# Also set in environment for current build
export CHROME_BIN=${CHROMIUM_BIN}
export PUPPETEER_EXECUTABLE_PATH=${CHROMIUM_BIN}

# Verify installation
echo "=== Verifying Chromium ==="
${CHROMIUM_BIN} --version

echo "Chromium and Puppeteer dependencies installed successfully."
