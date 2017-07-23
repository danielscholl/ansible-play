# Ansible Playground

This repository is to be used for playing with and creating Ansible Playbooks.


## Vagrant Instructions

Vagrant up will initialize a ubuntu server with up to date patches and ready for ansible commands.

```bash
$ vagrant up
```

### Running a playbook

```bash
$ INVENTORY_FILE="ansible/hosts/vagrant"
$ ansible-playbook -i ${INVENTORY_FILE} ansible/<playbookname>.yml
```

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


## Notes to Remember

### Use JQ to quickly retrieve ansible variables

```bash
$ ansible jumpserver -m setup   | sed 's/.*|.*=>.*/{/g' |jq .ansible_facts.ansible_env
```


