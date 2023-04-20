#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

dnf install -y \
  direnv \
  gh \
  hugo \
  pre-commit \
  python3-pip \
  python3-virtualenv
dnf update -y

dnf clean all
