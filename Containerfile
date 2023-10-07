ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-38}"

FROM registry.fedoraproject.org/fedora-toolbox:${FEDORA_MAJOR_VERSION}

# (Re-)Install packages which we expect to be in the toolbox already, for good measure
RUN dnf install -y \
        bash-completion \
        bzip2 \
        glibc-all-langpacks \
        glibc-locale-source \
        gnupg2-smime \
        hostname \
        iproute \
        iputils \
        keyutils \
        krb5-libs \
        man-db \
        man-pages \
        mtr \
        nss-mdns \
        openssh-clients \
        pigz \
        rsync \
        tcpdump \
        traceroute \
        tree \
        unzip \
        which \
        whois \
        words \
        xorg-x11-xauth \
        xz \
        zip

# Install packages otherwise installed by Distrobox on its first run
RUN dnf install -y \
        bash \
        bc \
        curl \
        diffutils \
        dnf-plugins-core \
        findutils \
        gnupg2 \
        less \
        lsof \
        ncurses \
        pam \
        passwd \
        pinentry \
        procps-ng \
        shadow-utils \
        sudo \
        time \
        tzdata \
        util-linux \
        vte-profile \
        wget \
        mesa-dri-drivers \
        mesa-vulkan-drivers \
        vulkan

# Personalized packages
RUN dnf install -y \
        adw-gtk3-theme \
        bind-utils \
        ccache \
        cpio \
        direnv \
        dosfstools \
        file \
        fuse \
        gh \
        gtk3 \
        gtk4 \
        hugo \
        ipcalc \
        jq \
        just \
        nodejs \
        qt5-qtbase-gui \
        patch \
        pinentry \
        pipx \
        pre-commit \
        python-unversioned-command \
        python3-pip \
        python3-virtualenv \
        syslinux \
        tmux \
        vim \
        xorriso \
        xz-devel \
        yamllint

# Pre-install host-spawn and distrobox-host-exec
ADD host-spawn-with-docker-host.patch /tmp/
RUN git clone https://github.com/89luca89/distrobox.git --single-branch /tmp/distrobox && \
    cp /tmp/distrobox/distrobox-host-exec /usr/bin/distrobox-host-exec && \
    wget https://github.com/1player/host-spawn/releases/download/$(cat /tmp/distrobox/distrobox-host-exec | grep host_spawn_version= | cut -d "\"" -f 2)/host-spawn-$(uname -m) -O /usr/bin/host-spawn && \
    chmod +x /usr/bin/host-spawn && \
    rm -drf /tmp/distrobox

# install microsoft VS Code
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' && \
    dnf install -y code

# run some things out of the host
RUN ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/buildah && \
    ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/cosign && \
    ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
    ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/skopeo && \
    ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \
    ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/htop && \
    ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/xdg-open

# Cleanup
RUN rm -rf /tmp/* && \
    dnf clean all
