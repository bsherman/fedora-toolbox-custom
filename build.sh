#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

dnf install -y \
  bind-utils \
  ccache \
  cpio \
  direnv \
  dosfstools \
  file \
  fuse \
  gh \
  google-droid-fonts-all \
  gtk3 \
  gtk4 \
  hugo \
  ipcalc \
  nodejs \
  qt5-qtbase-gui \
  patch \
  pipx \
  pre-commit \
  python3-pip \
  python3-virtualenv \
  source-foundry-hack-fonts \
  syslinux \
  tmux \
  vim \
  xorriso \
  xz-devel \
  yamllint
dnf update -y

dnf clean all
