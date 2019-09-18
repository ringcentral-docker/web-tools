FROM node:12

# Puppeteer
# https://github.com/adrianchia/docker-node-puppeteer/blob/master/12/Dockerfile
# https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker
# https://github.com/GoogleChrome/puppeteer/issues/290#issuecomment-322921352

RUN apt-get update && \
apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget \
&& wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
&& sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
&& apt-get update \
&& apt-get install -y google-chrome-stable xvfb fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont \
  gtk2-engines-pixbuf xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable imagemagick x11-apps default-jre \
      --no-install-recommends \
&& rm -rf /var/lib/apt/lists/* \
#&& apt-get purge --auto-remove -y curl \
&& rm -rf /src/*.deb

# It's a good idea to use dumb-init to help prevent zombie chrome processes
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

ENV DISPLAY=:99

# Java

# RUN apt-get install -yq default-jre && \  # installed on prev step
RUN java -version

# Sonar

WORKDIR /opt
RUN apt-get install -yq unzip && \
    curl -s -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.1.0.1829-linux.zip -o sonar.zip && \
    unzip -qq sonar.zip && \
    rm sonar.zip && \
    ln -s /opt/sonar-scanner-4.1.0.1829-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    sonar-scanner --version
