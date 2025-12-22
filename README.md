# Web Tools Docker Images

Multi-platform Docker images with Node.js, Java, Maven, Gradle, and development tools.

## Supported Platforms

- linux/amd64
- linux/arm64

## Available Images

| Name | Node | JDK | Gradle | Docker Hub | GitHub Package |
|------|------|-----|--------|------------|----------------|
| node20-jdk8 | 20.18.0 | 8 | 7.6 | `ringcentral/web-tools:node20-jdk8` | `ghcr.io/ringcentral-docker/web-tools:node20-jdk8` |
| node22-jdk8 | 22.11.0 | 8 | 7.6 | `ringcentral/web-tools:node22-jdk8` | `ghcr.io/ringcentral-docker/web-tools:node22-jdk8` |
| node20-jdk11 | 20.18.0 | 11 | 7.6 | `ringcentral/web-tools:node20-jdk11` | `ghcr.io/ringcentral-docker/web-tools:node20-jdk11` |
| node22-jdk11 | 22.11.0 | 11 | 7.6 | `ringcentral/web-tools:node22-jdk11` | `ghcr.io/ringcentral-docker/web-tools:node22-jdk11` |
| node20-jdk17 | 20.18.0 | 17 | 8.5 | `ringcentral/web-tools:node20-jdk17` | `ghcr.io/ringcentral-docker/web-tools:node20-jdk17` |
| node22-jdk17 | 22.11.0 | 17 | 8.5 | `ringcentral/web-tools:node22-jdk17` | `ghcr.io/ringcentral-docker/web-tools:node22-jdk17` |
| node20-jdk21 | 20.18.0 | 21 | 8.5 | `ringcentral/web-tools:node20-jdk21` | `ghcr.io/ringcentral-docker/web-tools:node20-jdk21` |
| node22-jdk21 | 22.11.0 | 21 | 8.5 | `ringcentral/web-tools:node22-jdk21` | `ghcr.io/ringcentral-docker/web-tools:node22-jdk21` |

## Included Tools

- **Node.js** - JavaScript runtime
- **Maven** - Java build tool
- **Gradle** - Build automation
- **Chromium** - Headless browser for Puppeteer
- **Sonar Scanner** - Code quality analysis
- **Checkmarx** - Security scanning (cx-flow, sca-resolver)
- **Git, Mercurial** - Version control
- **Python3** - For npm native modules

## Usage

```bash
# Pull from Docker Hub
docker pull ringcentral/web-tools:node22-jdk21

# Pull from GitHub Container Registry
docker pull ghcr.io/ringcentral-docker/web-tools:node22-jdk21

# Run
docker run -it ringcentral/web-tools:node22-jdk21 bash
```

## Build Locally

```bash
docker build \
  --build-arg BASE_IMAGE_TAG=22.11.0-jdk21 \
  --build-arg GRADLE_VERSION=8.5 \
  --build-arg SONAR_VERSION=4.8.0.2856 \
  --build-arg CX_FLOW_VERSION=1.7.11 \
  --build-arg CX_FLOW_JAR=cx-flow.jar \
  --build-arg SCA_RESOLVER_VERSION=2.12.36 \
  -t my-web-tools:node22-jdk21 .
```

## License

MIT License
