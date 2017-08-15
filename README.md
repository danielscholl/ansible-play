# Ansible Playground

This repository is to be used for playing with and creating Ansible Playbooks.


## Localhost Instructions

Vagrant is used on the localhost, but is wrapped in a bash script abstraction layer to automatically create the inventory files and modify the ansible.cfg as necessary.

- ./initlocal.sh <unique> <count>
  - Create the Vagrant Machines requested
  - Provision the Machine with the default playbook _./ansible/playbooks/initServer.yml_
  - Create an inventory file ./ansible/inventories/vagrant/hosts

The vagrantfile requires unique and count to be passed as environment variables.


```bash
$ ./initlocal.sh vm 2
$ unique=vm count=2 vagrant ssh vm2
```

### Test Ansible

The init scripts automatically create the necessary ansible.cfg and inventory files.  Test the connectivity to the servers that were created.

```bash
ansible all -m ping
```

### Running a playbook

```bash
$ ansible-playbook ansible/<playbookname>.yml
```

#### Install a Swarm Cluster

Playbook swarmCluster installs docker and can configure servers into a swarm.

To configure a swarm you must modify the inventory file and tag the servers as manager or worker.

```bash
[manager]
vm1
vm2
vm3

[worker]
vm4
vm5
vm6
```

>NOTE: To configure a swarm on vagrant you must set the swarm interface variable to enp0s3 in vagrant/group_vars.
swarm_iface: 'enp0s8'


### Connect to server

```bash
$ vagrant ssh
```

### Remove Server

```bash
$ vagrant destroy
```

## Azure Instructions

Init Script will create a simple Azure Virtual Machine with up to date patches and ready for ansible commands.

```bash
$ ./init.sh <unique>
```

### Running a playbook

```bash
$ INVENTORY_FILE="ansible/hosts/azure"
$ ansible-playbook -i ${INVENTORY_FILE} ansible/<playbookname>.yml
```

### Connect to server

```bash
$ ./connect.sh <unique>
```

### Remove Server

```bash
$ ./clean.sh <unique>
```


## Example Activities

### Build a Swarm Cluster with 3 manager nodes and 3 worker nodes

```bash
$ ./init.sh <unique> 6
$ ansible-playbook ./ansible/playbooks/swarmCluster.yml
```

### Configure Persistant Storage

```bash
$ vboxwebsrv -H 0.0.0.0 -v >/dev/null 2>&1 &
$ ansible-playbook ./ansible/playbooks/storageVagrant.yml

# When done bring back the task and kill it
$ fg
```


## Notes to Remember

### Use JQ to quickly retrieve ansible variables

```bash
$ ansible jumpserver -m setup   | sed 's/.*|.*=>.*/{/g' |jq .ansible_facts.ansible_env
```

### Initialize Virtualbox for Rexray Storage

```bash
$ VBoxManage setproperty websrvauthlibrary null
$ vboxwebsrv -H 0.0.0.0 -v
```

