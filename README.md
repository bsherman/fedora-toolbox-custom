# fedora-toolbox-custom

[![build-toolbox](https://github.com/bsherman/fedora-toolbox-custom/actions/workflows/build.yml/badge.svg)](https://github.com/bsherman/fedora-toolbox-custom/actions/workflows/build.yml)

Customized, daily updated, `fedora-toolbox` image with a few extras for dev work.

## What is this?

These toolbox images are customized how I want, and avoid the need to install and upgrade RPMs after createing a distrobox.

Based on [fedora-toolbox](https://github.com/containers/toolbox/tree/main/images/fedora/) of appropriate fedora version.

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the appropriate command:

    cosign verify --key cosign.pub ghcr.io/bsherman/fedora-toolbox-custom
