#!/bin/bash
set -e

echo "Installing base tools..."

apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    zip \
    curl \
    wget \
    jq \
    bash \
    openssh-client \
    mercurial \
    rng-tools \
    python3 \
    python3-pip \
    make \
    g++ \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install yq
YQ_VERSION="v4.50.1"
ARCH=$(dpkg --print-architecture)
case "${ARCH}" in
    amd64) YQ_ARCH="amd64" ;;
    arm64) YQ_ARCH="arm64" ;;
    *) echo "Unsupported architecture: ${ARCH}" && exit 1 ;;
esac
curl -sL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${YQ_ARCH}" -o /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq

# Verify installations
echo "=== Verifying base tools ==="
git --version
curl --version | head -1
jq --version
yq --version
python3 --version
echo "Base tools installed successfully."
