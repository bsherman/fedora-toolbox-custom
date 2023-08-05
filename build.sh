#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# update any not current packages
dnf update -y

# add packages desired for dev
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
  just \
  nodejs \
  qt5-qtbase-gui \
  patch \
  pipx \
  pre-commit \
  python-unversioned-command \
  python3-pip \
  python3-virtualenv \
  source-foundry-hack-fonts \
  syslinux \
  tmux \
  vim \
  xorriso \
  xz-devel \
  yamllint

# install microsoft VS Code
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf install -y code

dnf clean all
