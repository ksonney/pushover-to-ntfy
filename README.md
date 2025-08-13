# Pushover-to-NTFY

## Introduction

This is a simple project that allows sending of pushover messages to ntfy.sh. It 
utilizes push-watch and the ntfy command line client to do so. This Repository
contains: 

 - The Dockerfile to build it
 - startup.sh to run push-watch
 - send-to-ntfy to take the message from push-watch to ntfy.sh
 - build.sh which is what I use to make the container
 - This document

## Installation/Configuration

To get the container run

`docker pull ksonney/pushover-to-nfty:latest`

Create a "config" directory, and add an ntfy client.yml file to it

```
mkdir ./config
echo "default-host: [your host]
default-token: [your token]
# default-user:
# default-password:
# default-command:
# subscribe:" > ./config/client.yml
```

To get the keys needed for pushover, you will need to register a desktop client. To
register a client run

`docker run --rm ksonney/pushover-to-ntfy login username password`

This will return the ID and Secret needed. Store those somewhere safe, you'll need them
at run time

## Running Standalone

```
docker run \
  -e PUSHOVER_ID=[client id] \
  -e PUSHOVER_SECRET=[secret] \
  -e NTFY_TOPIC="[topic to publish to] \
  -v ./config/:/etc/ntfy/ \
  pushover-to-ntfy
```

Send a push to the registered client, and it will show up in the topic in NTFY!

## Running in docker compose Docker Compose


```yaml
service:
  pushover-to-ntfy:
    image: ksonney/pushover-to-ntfy:latest
    restart: unless-stopped
    environment:
      - PUSHOVER_ID: [client id]
      - PUSOVER_SECRET: [secret]
      - NTFY_TOPIC: [topic to publish to]
    volumes:
      - ./config:/etc/ntfy
```

## More information

 - [Pushover](https://pushover.net)
 - [ntfy.sh](https://ntfy.sh/)
 - [push-watch](https://github.com/hrntknr/push-watch)
