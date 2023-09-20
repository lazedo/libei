#!/bin/bash

## base build

apk add abuild lua-aports build-base alpine-sdk \
    autoconf automake libtool \
    git coreutils bash which \
    wget curl jq \
    su-exec sudo \
    util-linux-dev util-linux \
    gpg \
    rpm2cpio sshfs s3fs-fuse

# erlang-dev 26
apk add erlang-dev --repository https://dl-cdn.alpinelinux.org/alpine/edge/community    

adduser --gecos "" --disabled-password -u 1000 -G abuild -s /bin/bash -D me

mkdir -p /etc/sudoers.d
echo "%me ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ci \
chmod 0440 /etc/sudoers.d/me \
echo "%me ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

su me
