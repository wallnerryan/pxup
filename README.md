# pxup

Bring up a Portworx cluster using Vagrant and libvirt based on docker

# Usage

0. One time setup: `./bootstrap.sh`
1. Set the name of your image name in `global_vars.yaml` 
2. Adjust `roles/common/files/config.json`
3. Run `./up.sh` and enjoy

# Infrastructure

To increase the number of nodes, disks, or memory edit the following values
in the Vagrantfile:

```
NODES = 3
DISKS = 3
MEMORY = 4096
CPUS = 2
```

