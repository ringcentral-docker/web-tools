#!/bin/bash
set -e

CX_FLOW_JAR=${1:-cx-flow.jar}

echo "Installing Checkmarx tools..."
echo "  CX_FLOW_VERSION: ${CX_FLOW_VERSION}"
echo "  CX_FLOW_JAR: ${CX_FLOW_JAR}"
echo "  SCA_RESOLVER_VERSION: ${SCA_RESOLVER_VERSION}"

# Detect architecture
ARCH=$(dpkg --print-architecture)
case "${ARCH}" in
    amd64) SCA_ARCH="linux64" ;;
    arm64) SCA_ARCH="linux-arm64" ;;
    *) echo "Unsupported architecture: ${ARCH}" && exit 1 ;;
esac

echo "  Architecture: ${ARCH} -> ${SCA_ARCH}"

cd /opt

# Install cx-flow (Java-based, architecture independent)
mkdir -p cx-flow
curl -sL "https://github.com/checkmarx-ltd/cx-flow/releases/download/${CX_FLOW_VERSION}/${CX_FLOW_JAR}" \
    -o ./cx-flow/cx-flow.jar

# Install sca-resolver (architecture specific)
mkdir -p sca-resolver
curl -sL "https://sca-downloads.s3.amazonaws.com/cli/${SCA_RESOLVER_VERSION}/ScaResolver-${SCA_ARCH}.tar.gz" \
    -o ./sca-resolver/ScaResolver.tar.gz \
    && tar -xzf ./sca-resolver/ScaResolver.tar.gz -C ./sca-resolver \
    && rm ./sca-resolver/ScaResolver.tar.gz

echo "Checkmarx tools installed successfully."
