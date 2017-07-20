# Init

This role installs the latest patches to a server and reboots.

## Requirements

This role has no specific requirements

## Task Items

1. Install the latest patches to a server followed by a reboot

## Role Variables

None


## Examples

1. Initialize a box

```yaml
- hosts: all
  roles:
    - init
```

## Dependencies

None
