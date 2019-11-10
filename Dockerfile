FROM phusion/baseimage:master

WORKDIR /opt/

RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    apt-transport-https \
    curl \
    git \
    libopus0 \
    opus-tools \
    libopus-dev \
    libsodium-dev \
    ffmpeg \
    rsync \
    python \
    python3-pip \
    tzdata \
 && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-bionic-prod bionic main" > /etc/apt/sources.list.d/dotnetdev.list'

RUN curl -O -sS https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

RUN add-apt-repository ppa:chris-lea/redis-server
RUN	apt-get update && apt-get install -y --no-install-recommends \
    dotnet-sdk-2.1 \
    redis-server \
 && rm -rf /var/lib/apt/lists/*

RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && chmod a+rx /usr/local/bin/youtube-dl

# TODO: still figuring out the cleanest way (probably hooks: https://git.io/JeVb0) to handle no-cache with dockerhub autobuilds (see *longstanding* issue: https://github.com/moby/moby/issues/1996)

RUN curl -H "Cache-Control: no-cache" https://raw.githubusercontent.com/shikhir-arora/Nadecker/master/install.sh -o ./install.sh && chmod 755 install.sh && ./install.sh
RUN curl -O -H "Cache-Control: no-cache" https://raw.githubusercontent.com/shikhir-arora/Nadecker/master/nadeko_autorestart.sh && chmod 755 nadeko_autorestart.sh

VOLUME ["/root/nadeko"]
CMD ["sh","/opt/nadeko_autorestart.sh"]
