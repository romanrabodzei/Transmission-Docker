# Docker container with Transmission client

Transmission is a fast, easy, and free BitTorrent client. It has the features you would want from a BitTorrent client: encryption, a web interface, peer exchange, magnet links, DHT, µTP, UPnP, and NAT-PMP port forwarding, webseed support, watch directories, tracker editing, global and per-torrent speed limits, and more.

The Docker version of Transmission allows you to run this BitTorrent client in a Docker container, which can be very useful for maintaining isolation and control over the resources it uses. This can be particularly beneficial if you're running it on a server with other services.

> [!IMPORTANT]
> **Please note that you should always be mindful of the legal and ethical considerations when using BitTorrent clients and only use them for sharing and downloading content that is free to distribute.**
>

For more information, visit the official site [https://transmissionbt.com/](https://transmissionbt.com/)



## Build status
[![Image build and publish](https://github.com/romanrabodzei/Transmission-Docker/actions/workflows/workflow.yml/badge.svg?branch=main)](https://github.com/romanrabodzei/Transmission-Docker/actions/workflows/workflow.yml)

## Run a container 
```bash
docker container run \
--detach \
--name transmission \
--publish 8080:8080/tcp \
--volume /incompleted/:/incompleted \
--volume /completed/:/completed \
romanrabodzei/transmission:latest
```

`--volume /incompleted/:/your_folder` - set a folder for temp files.

`--volume /completed/:/your_folder` - set a folder for completed tasks.

## Setting up a username and password

The default username is *transmission*, and the password is *transmission*. To set up your own username and password, change the following lines in the settings.json file
```json
"rpc-password": "password",
"rpc-username": "username",
```

Then, build a docker image and run it.

```bash
docker build -t transmission:latest -f ./Dockerfile.transmission .

docker container run \
--detach \
--name transmission \
--publish 8080:8080/tcp \
--volume /incompleted/:/incompleted \
--volume /completed/:/completed \
transmission:latest
```

The screenshot below shows the web interface of the Transmission client.
![WebUI](screenshot.png)
