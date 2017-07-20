# Cassandra

This role installs a Cassandra Server.

>__THIS ROLE IS UNDER DEVELOPMENT__

## Requirements

This role has no specific requirements

## Task Items

1. Install the latest patches to a server followed by a reboot

## Role Variables

`cassandra` dictionary or group in hosts inventory. See example:

    [cassandra]
    cs1.midoexample.net
    cs2.midoexample.net
    cs3.midoexample.net


## Examples

1. Initialize a box

```yaml
hosts: cassandra
      roles:
        - role: ansible-cassandra
          cassandra_hosts: '{{ groups["cassandra"] }}'
```

## Dependencies

None


