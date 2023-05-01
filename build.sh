#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

dnf install -y \
  cpio \
  direnv \
  file \
  gh \
  hugo \
  jq \
  patch \
  pre-commit \
  python3-pip \
  python3-virtualenv \
  tmux
dnf update -y

pip3 install yq

dnf clean all
