#!/bin/bash
set -e

echo "Installing Chromium and Puppeteer dependencies..."

# Install Chromium and dependencies for Puppeteer
apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    chromium-sandbox \
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
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Set Puppeteer environment variables
echo 'export CHROME_BIN=/usr/bin/chromium' >> /etc/profile.d/chromium.sh
echo 'export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium' >> /etc/profile.d/chromium.sh
echo 'export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true' >> /etc/profile.d/chromium.sh
chmod +x /etc/profile.d/chromium.sh

echo "Chromium and Puppeteer dependencies installed successfully."
