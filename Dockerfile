FROM ubuntu:jammy
USER root
RUN mkdir /opt/ntfy /opt/push-watch /etc/ntfy
VOLUME ["/etc/ntfy"]
RUN apt update && apt install -y ca-cacert certinfo 
WORKDIR /opt/ntfy
ENV NTFY_VER=2.14.0
ADD https://github.com/binwiederhier/ntfy/releases/download/v${NTFY_VER}/ntfy_${NTFY_VER}_linux_amd64.tar.gz /opt/ntfy/
RUN tar zxvf ntfy_${NTFY_VER}_linux_amd64.tar.gz && cp -a ntfy_${NTFY_VER}_linux_amd64/ntfy /usr/local/bin && cp -a ntfy_${NTFY_VER}_linux_amd64/client/client.yml /etc/ntfy/ && rm -Rf ntfy_${NTFY_VER}_linux_amd64 ntfy_${NTFY_VER}_linux_amd64.tar.gz

WORKDIR /opt/push-watch
ENV WATCH_VER=0.1.2
ADD https://github.com/hrntknr/push-watch/releases/download/v${WATCH_VER}/push-watch-x86_64-unknown-linux-gnu /usr/local/bin/push-watch
RUN chmod a+x /usr/local/bin/push-watch

WORKDIR /
ADD send-to-ntfy /opt/push-watch/send-to-ntfy
ADD startup.sh /startup.sh

RUN chown -R root:root /usr/local/bin && chmod -R 755 /startup.sh /usr/local/bin /opt/push-watch/send-to-ntfy

ENTRYPOINT ["/bin/sh","/startup.sh" ]
