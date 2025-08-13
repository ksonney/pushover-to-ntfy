#!/bin/bash
docker rmi ksonney/pushover-to-ntfy
docker buildx build --tag docker.io/ksonney/pushover-to-ntfy:latest --push --platform linux/amd64 .
