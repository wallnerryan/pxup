#!/bin/sh

## CONFIGURATION

start_services() {
    if ! systemctl is-active libvirtd > /dev/null ; then
        echo "--> Starting libvirtd service"
        sudo systemctl start libvirtd
        sudo systemctl enable libvirtd
    fi
}

fedora_setup() {
    echo "--> Installing applications (Fedora)"
    sudo dnf -y install libvirt \
        dnsmasq \
        qemu \
        qemu-kvm \
        git \
        golang \
        docker \
        jq \
        wget \
        virt-install \
        virt-manager
    if [ $? -ne 0 ] ; then
        echo "Unable to install packages"
        exit 1
    fi

    start_services
}

centos_setup() {
    echo "--> Installing applications (CentOS)"
    sudo yum -y install libvirt \
        dnsmasq \
        qemu \
        qemu-kvm \
        git \
        golang \
        docker \
        jq \
        wget \
        virt-install \
        virt-manager
    if [ $? -ne 0 ] ; then
        echo "Unable to install packages"
        exit 1
    fi

    start_services
}

host_setup() {
    if grep "CentOS" /etc/redhat-release > /dev/null 2>&1 ; then
        centos_setup
    elif grep "Fedora" /etc/redhat-release > /dev/null 2>&1 ; then
        fedora_setup
    else
        echo "Only CentOS or Fedora are supported"
        exit 1
    fi
}

host_setup
echo "--> Done"
