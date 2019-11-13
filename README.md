# isam-ansible
https://hub.docker.com/r/mludocker/isam-ansible/dockerfile

This will install and config the centos machine for the use of ansible and IBM tools

# OS
CentOS 7 Supported
CentOS 8 Supported

# Overview
This script is built on top of CentOS 7, it will install the Ansible and the ISAM Python module, ISAM Ansible module, and ISAM Ansible Roles.

The goal is to allow a user to run ISAM Ansible playbook quickly.

# Pre-Requisites
You need to have a installed CentOS 7 machine.

# Run
Download:
```
git clone https://github.com/CoolZeroNL/isam-ansible.git
```

```
cd isam-ansible
./00-run.sh
```

# Usage
# Usage:
## Create your inventories files.
```
inventories/
    └── test
        ├── group_vars
        │   ├── all
        │   │   ├── vars.yml
        │   │   └── vault.yml
        │   └── boulder.yml
        ├── hosts
        └── host_vars
            ├── 192.168.198.144
            │   ├── vars.yml
            │   └── vault.yml
            ├── 192.168.198.145
            │   ├── vars.yml
            │   └── vault.yml
            └── 192.168.198.153
                ├── vars.yml
                └── vault.yml
```

or Clone Private Inventories
```
cd ~
git clone https://github.com/CoolZeroNL/isam-ansible-inventories.git
```

# edit inventories files
edit the vars.yml and vault.yml files

# run
```
cd ~/isam-ansible-playbook-sample
ansible-playbook -i ../isam-ansible-inventories/inventories/local base/activate_modules.yml
```


# Orginal sample from isam-ansible-playbook-sample:
```
cd ~/isam-ansible-playbook-sample
ansible-playbook -i inventories/test base/activate_modules.yml
```

