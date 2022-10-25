FROM gradle:7.5.1-jdk8-focal

COPY docker/apt.conf /etc/apt

WORKDIR /scratch
COPY Requirements.txt Requirements.txt

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Etc/UTC
RUN apt-get update \
        --quiet=2 --assume-yes --no-install-recommends \
    && apt-get install \
        --quiet=2 --assume-yes --no-install-recommends $(cat Requirements.txt) \
    && apt-get clean \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/*
