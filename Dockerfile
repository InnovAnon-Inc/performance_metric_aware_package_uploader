# performance metric aware package uploader
# handles -march= / -mtune= architecture-specific distribution

#FROM debian:bookworm-slim
FROM python:3.13-slim

RUN apt-get update                             \
&&  apt-get install -y --no-install-recommends \
    git                                        \
    ca-certificates                            \
    inotify-tools                              \
&&  rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY ./uploader.sh /usr/local/bin/uploader.sh
RUN chmod +x /usr/local/bin/uploader.sh

ENTRYPOINT ["/usr/local/bin/uploader.sh"]
