FROM registry.access.redhat.com/ubi9/ubi:latest

RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
RUN dnf -y install ninja-build pandoc
