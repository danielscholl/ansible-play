# Jumpserver

This role installs and configures a box that could then be used as a jumpserver into a protected environment to manage servers in that environment.

## Requirements

This role has no specific requirements

## Task Items

1. Install the latest version of Docker.
2. Install the Azure CLI
3. Install Ansible

## Role Variables

The variables that can be passed to this role and a brief description about them are as follows.

```yaml
# Docker Setup Information
docker_apt_key_url: https://download.docker.com/linux/ubuntu/gpg
docker_apt_key_sig: 0EBFCD88
docker_apt_repository: deb https://download.docker.com/linux/ubuntu {{ ansible_distribution_release }} stable

# Azure Setup Information
azure_apt_key_server: packages.microsoft.com
azure_apt_key_sig: 417A0893
azure_apt_repository: deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main
```

## Examples

1. Install a Jumpserver

```yaml
- hosts: all
  roles:
    - jumpserver
```

## Dependencies

None
