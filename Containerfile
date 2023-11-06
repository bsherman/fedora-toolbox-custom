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

# Pre-install host-spawn and distrobox-host-exec with a patch to include DOCKER_HOST env
ADD host-spawn-with-docker-host.patch /tmp/
RUN git clone https://github.com/89luca89/distrobox.git --single-branch /tmp/distrobox && \
    cd /tmp/distrobox && \
    git apply /tmp/host-spawn-with-docker-host.patch && \
    cp /tmp/distrobox/distrobox-host-exec /usr/bin/distrobox-host-exec-env && \
    wget https://github.com/1player/host-spawn/releases/download/$(cat /tmp/distrobox/distrobox-host-exec | grep host_spawn_version= | cut -d "\"" -f 2)/host-spawn-$(uname -m) -O /usr/bin/host-spawn && \
    chmod +x /usr/bin/host-spawn && \
    rm -drf /tmp/distrobox

# Set up cleaner Distrobox integration and run some things from host
RUN dnf install -y 'dnf-command(copr)' && \
    dnf copr enable -y kylegospo/distrobox-utils && \
    dnf install -y \
        xdg-utils-distrobox \
        adw-gtk3-theme && \
    ln -sf /usr/bin/distrobox-host-exec-env /usr/local/bin/buildah && \
    ln -sf /usr/bin/distrobox-host-exec-env /usr/local/bin/docker && \
    ln -sf /usr/bin/distrobox-host-exec-env /usr/local/bin/docker-compose && \
    ln -sf /usr/bin/distrobox-host-exec-env /usr/local/bin/podman && \
    ln -sf /usr/bin/distrobox-host-exec-env /usr/local/bin/skopeo && \
    ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \
    ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/htop && \
    ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/tmux

# Install basic dev tools & libs
RUN dnf install -y --setopt=install_weak_deps=False \
    autoconf \
    automake \
    binutils \
    cmake \
    gcc \
    gcc-c++ \
    gdb \
    glibc-devel \
    indent \
    libtool \
    ltrace \
    patch \
    pkgconf \
    strace

# Personalized packages
RUN dnf install -y --setopt=install_weak_deps=False \
        bind-utils \
        ccache \
        cpio \
        dosfstools \
        file \
        gh \
        ipcalc \
        jq \
        just \
        mosquitto \
        nmap \
        patch \
        pinentry \
        python-unversioned-command \
        python3-pip \
        python3-virtualenv \
        syslinux \
        vim \
        xorriso \
        xz-devel

# install dependencies for JetBrains IDEs
RUN dnf install -y \
        fuse \
        gtk3 \
        gtk4 \
        qt5-qtbase-gui

# install microsoft VS Code
#RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
#    sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' && \
#    dnf install -y code

# Cleanup
RUN rm -rf /tmp/* && \
    dnf clean all
