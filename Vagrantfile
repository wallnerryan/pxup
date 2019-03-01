# -*- mode: ruby -*-
# vi: set ft=ruby :
#

# If you change the number of drives, you will need to update roles/common/files/config.json
NODES = 3
DISKS = 3
MEMORY = 4096
CPUS = 2

### TYPE HERE A PREFIX ###
PREFIX = "ryanpx" 

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
    config.vm.box = "centos/7"

    # Override
    config.vm.provider :libvirt do |v,override|
        override.vm.synced_folder '.', '/home/vagrant/sync', disabled: true
    end

    # Make the glusterfs cluster, each with DISKS number of drives
    (0..NODES-1).each do |i|
        config.vm.define "#{PREFIX}-node#{i}" do |node|
            node.vm.hostname = "#{PREFIX}-node#{i}"
            node.vm.network :private_network, ip: "192.168.20.10#{i}"

            (0..DISKS-1).each do |d|
                node.vm.provider :libvirt do  |lv|
                    driverletters = ('b'..'z').to_a
                    lv.storage :file, :device => "vd#{driverletters[d]}", :path => "#{PREFIX}-disk-#{i}-#{d}.disk", :size => '1024G'
                    lv.memory = MEMORY
                    lv.cpus = CPUS
                end
            end

            if i == (NODES-1)
                # View the documentation for the provider you're using for more
                # information on available options.
                node.vm.provision :ansible do |ansible|
                    ansible.limit = "all"
                    ansible.playbook = "site.yml"
                    ansible.groups = {
                        "nodes" => (0..NODES-1).map {|j| "#{PREFIX}-node#{j}"},
                    }
                end
            end
        end
    end
end
