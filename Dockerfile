ARG BASEIMAGE="registry.redhat.io/ubi9/ubi:latest"
FROM ${BASEIMAGE}
ARG OS_VERSION_MAJOR=''
ARG DRIVER_VERSION=1.15.1-15
ARG TARGET_ARCH=''
ARG KERNEL_VERSION=''
ARG REDHAT_VERSION='el9'
RUN ls -alhZ /tmp
RUN ls -alhZ /var/cache/dnf/
RUN . /etc/os-release \
    && export OS_VERSION_MAJOR="${OS_VERSION_MAJOR:-$(echo ${VERSION} | cut -d'.' -f 1)}" \
    && export TARGET_ARCH="${TARGET_ARCH:-$(arch)}" \
    && dnf -y update && dnf -y install kernel-headers${KERNEL_VERSION:+-}${KERNEL_VERSION} make git kmod
RUN if grep -q -i "centos" /etc/os-release; then \
        echo "CentOS detected" &&  \
        dnf -y install 'dnf-command(config-manager)' && \
        dnf -y config-manager --set-enabled crb && \
        dnf -y install epel-release epel-next-release ; \
    elif grep -q -i "red hat" /etc/os-release; then \
        echo "Red Hat detected" && \
        subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms && \
        dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm ;\
    else \
        echo "Unsupported OS" && exit 1; \
    fi
RUN dnf -y install ninja-build pandoc
