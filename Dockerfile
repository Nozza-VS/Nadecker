# Download Ubuntu base image from phusion
# https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:master

# Define working directory
WORKDIR /opt/

# Let us begin
RUN apt-get update
RUN apt-get install software-properties-common apt-transport-https curl -y	
RUN apt-get install -y wget
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

# Just incase
# Register the trusted Microsoft signature key
RUN	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN	mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# Register the Microsoft Product feed for your distro version
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-bionic-prod bionic main" > /etc/apt/sources.list.d/dotnetdev.list'


# Updating existing tools
RUN	apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

# Install Git
RUN	apt-get update && apt-get install -y git

# Install apt-transport-https
RUN	apt-get update && apt-get install -y apt-transport-https

# Install .NET Core SDK 
RUN	apt-get update && apt-get install -y dotnet-sdk-2.1

# Install Redis-server
RUN	apt-get update && apt-get install -y redis-server

# Install required software
RUN	apt-get update && apt-get install -y libopus0 opus-tools libopus-dev libsodium-dev ffmpeg rsync python python3-pip tzdata

# Add youtube-dl
RUN	curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && chmod a+rx /usr/local/bin/youtube-dl

# Download and install our upstream compatible version of Nadeko
RUN	curl -H "Cache-Control: no-cache" https://raw.githubusercontent.com/shikhir-arora/Nadecker/master/install.sh -o ./install.sh && chmod 755 install.sh && ./install.sh
RUN	curl -O -H "Cache-Control: no-cache" https://raw.githubusercontent.com/shikhir-arora/Nadecker/master/nadeko_autorestart.sh && chmod 755 nadeko_autorestart.sh
	
VOLUME ["/root/nadeko"]

CMD ["sh","/opt/nadeko_autorestart.sh"]
