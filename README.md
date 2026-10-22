# Web Tools Docker Images

Multi-platform Docker images with Node.js, Java, Maven, Gradle, and development tools.

## Supported Platforms

- linux/amd64
- linux/arm64

## Available Images

| Name | Node | JDK | Gradle | Docker Hub | GitHub Package |
|------|------|-----|--------|------------|----------------|
| node22-jdk8 | 22.23.4 | 8 | 7.6 | `ringcentral/web-tools:node22-jdk8` | `ghcr.io/ringcentral-docker/web-tools:node22-jdk8` |
| node24-jdk8 | 24.22.1 | 8 | 7.6 | `ringcentral/web-tools:node24-jdk8` | `ghcr.io/ringcentral-docker/web-tools:node24-jdk8` |
| node22-jdk11 | 22.23.4 | 11 | 7.6 | `ringcentral/web-tools:node22-jdk11` | `ghcr.io/ringcentral-docker/web-tools:node22-jdk11` |
| node24-jdk11 | 24.22.1 | 11 | 7.6 | `ringcentral/web-tools:node24-jdk11` | `ghcr.io/ringcentral-docker/web-tools:node24-jdk11` |
| node22-jdk17 | 22.23.4 | 17 | 8.5 | `ringcentral/web-tools:node22-jdk17` | `ghcr.io/ringcentral-docker/web-tools:node22-jdk17` |
| node24-jdk17 | 24.22.1 | 17 | 8.5 | `ringcentral/web-tools:node24-jdk17` | `ghcr.io/ringcentral-docker/web-tools:node24-jdk17` |
| node22-jdk21 | 22.23.4 | 21 | 8.5 | `ringcentral/web-tools:node22-jdk21` | `ghcr.io/ringcentral-docker/web-tools:node22-jdk21` |
| node24-jdk21 | 24.22.1 | 21 | 8.5 | `ringcentral/web-tools:node24-jdk21` | `ghcr.io/ringcentral-docker/web-tools:node24-jdk21` |
| node22-jdk25 | 22.23.4 | 25 | 9.7.1 | `ringcentral/web-tools:node22-jdk25` | `ghcr.io/ringcentral-docker/web-tools:node22-jdk25` |
| node24-jdk25 | 24.22.1 | 25 | 9.7.1 | `ringcentral/web-tools:node24-jdk25` | `ghcr.io/ringcentral-docker/web-tools:node24-jdk25` |

## Included Tools

- **Node.js** - JavaScript runtime
- **Maven** - Java build tool
- **Gradle** - Build automation
- **Chromium** - Headless browser for Puppeteer
- **Sonar Scanner** - Code quality analysis
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
  -t my-web-tools:node22-jdk21 .
```

## License

MIT License
