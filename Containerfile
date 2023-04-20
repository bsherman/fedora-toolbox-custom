ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-37}"

FROM registry.fedoraproject.org/fedora-toolbox:${FEDORA_MAJOR_VERSION}

ADD build.sh /tmp/build.sh

RUN /tmp/build.sh && rm /tmp/build.sh
