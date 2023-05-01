#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

dnf install -y \
  cpio \
  direnv \
  file \
  fuse \
  gh \
  gtk3 \
  gtk4 \
  hugo \
  jetbrains-mono-fonts-all \
  jq \
  patch \
  pre-commit \
  python3-pip \
  python3-virtualenv \
  tmux
dnf update -y

pip3 install yq

dnf clean all
