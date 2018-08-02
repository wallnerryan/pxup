# pxup

Bring up a Portworx cluster using Vagrant and libvirt based on docker

# Usage

* One time setup: `./bootstrap.sh`
* Set the name of your image name in `global_vars.yaml` 

An etcd server will be setup in node0 and configured in config.json. If you would like your
own etcd server endpoints you can adjust `roles/common/files/config.json`.

### Build the cluster

* Run `./up.sh` and enjoy

### Redeploy

Once the system is running, to redeploy a new version type:

```
$ ./update.sh
```

# Infrastructure

To increase the number of nodes, disks, or memory edit the following values
in the Vagrantfile:

```
NODES = 3
DISKS = 3
MEMORY = 4096
CPUS = 2
```

