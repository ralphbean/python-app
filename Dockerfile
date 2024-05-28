FROM registry.redhat.io/rhel9/rhel-bootc:9.4

RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
RUN dnf -y install ninja-build pandoc
