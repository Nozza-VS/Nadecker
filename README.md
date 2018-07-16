
[![Docker Build Status](https://img.shields.io/docker/build/shikhirarora/nadekobuild.svg?style=for-the-badge)](https://hub.docker.com/r/shikhirarora/nadekobuild/)

# NadekoBot + Docker = Nadecker!

**The dockerfile (tag: latest) is always built automatically to the latest release. See below!**

This is a docker container based on a upstream-maintained (but slight changes) version of [NadekoBot](http://github.com/shikhir-arora/NadekoBot). 

Upstream is auto-synced (PR opened and webhook notify) and kept **100% up-to-date** with the NadekoBot/1.9 (latest) branch thanks to the awesome [Backstroke](https://backstroke.co/) app.

As soon as any changes are pushed to the [NadekoBot](http://github.com/shikhir-arora/NadekoBot) branch (our fork), a webhook is triggered to the [Dockerhub](https://hub.docker.com/r/shikhirarora/nadekobuild/) and a new build is deployed. It takes about 15 minutes due to the base-image and size of dotnet-sdk to complete the build. 

Basically, I will accept the pull requests that are automatically posted within 5 minutes of an update to the upstream - and that will trigger a build. That way this is always fully up-to-date.

> In my setup we also use a popular Docker app called watchtower, which runs as a container and watches for new images. Once a new image is made as above under the "latest" tag, our watchtower will download, update, and clean up the old installation and post a webhook to our Discord channel -- this is checked every 2 minutes (:


- Base fork: `willysunny/Nadecker` 
