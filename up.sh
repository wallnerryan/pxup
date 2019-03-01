#!/bin/sh

docker save quay.io/porx/porxsdk:1 > $PWD/roles/common/files/px.img
vagrant up --provider=libvirt --no-provision $@ \
    && vagrant --provider=libvirt provision

