
[![Docker Build Status](https://img.shields.io/docker/build/shikhirarora/nadekobuild.svg?style=for-the-badge)](https://hub.docker.com/r/shikhirarora/nadekobuild/)

# NadekoBot + Docker = Nadecker!

**The dockerfile (tag: latest) is always built automatically to the latest release. See below!**

This is a docker container based on an upstream-maintained (with minor/non-breaking changes) version of [NadekoBot](http://github.com/shikhir-arora/NadekoBot). 

Upstream is auto-synced (PR opened and a webhook notifies me) and kept **100% up-to-date** with the NadekoBot/1.9 (latest) branch thanks to the awesome [Backstroke](https://backstroke.co/) app.

As soon as any changes are pushed to the [NadekoBot](http://github.com/shikhir-arora/NadekoBot) branch (our fork), a webhook is triggered to the [Dockerhub](https://hub.docker.com/r/shikhirarora/nadekobuild/) and a new build is deployed. It takes about 15 minutes to complete the build due to the Ubuntu 18.04 based `phusion/baseimage:master` image and the size of `dotnet-sdk`.

Basically, I will accept the auto-generated pull requests that are sync'ed with [Backstroke](https://backstroke.co/) and posted within ~5 minutes of any update to the upstream/1.9 repo - me doing this will trigger a build. That way this is always fully up-to-date, and I am usually very fast at accepting the PR's. Additionally, just like the upstream, our fork runs an [Appveyor CI check](https://ci.appveyor.com/project/shikhir-arora/nadekobot) for each PR/commit, ensuring that there's nothing causing a basic broken build (like a syntax error) before anything is merged.

The setup we use also includes a popular Docker app called [Watchtower](https://github.com/v2tec/watchtower), which runs as a container and watches for new images. Once a new image is made as above under the "latest" tag, our watchtower will download, update, and clean up the old installation and post a webhook to our Discord channel -- this is checked every 2 minutes (: 


---

### First Run (with automatic updates using [Watchtower](https://github.com/v2tec/watchtower) & cleanup of the old image)  

> ***This assumes you have Docker CE installed, root access and your completed `credentials.json` file are in your home folder (`cd ~` and copy the `credentials.json` file here; you only have to do so once).***


```bash

cd ~ || exit && docker create --name=nadeko -v /nadeko/conf:/root/nadeko -v /nadeko/data/:/opt/NadekoBot/src/NadekoBot/bin/Release/netcoreapp2.1/data shikhirarora/nadekobuild:latest && docker cp credentials.json nadeko:/root/nadeko && docker start nadeko && docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock v2tec/watchtower --interval 120 --cleanup

```
