# isam-ansible
https://hub.docker.com/r/mludocker/isam-ansible/dockerfile

This will install and config the centos machine for the use of ansible and IBM tools

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

ansible-playbook -i inventories/production prod-settings.yml -vvv
