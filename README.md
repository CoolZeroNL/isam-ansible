# 1. index

<!-- TOC -->

- [1. index](#1-index)
- [2. isam-ansible](#2-isam-ansible)
- [3. OS](#3-os)
- [4. Overview](#4-overview)
- [5. Pre-Requisites](#5-pre-requisites)
- [6. Run](#6-run)
- [7. Usage](#7-usage)
- [8. Usage:](#8-usage)
    - [8.1. Create your inventories files.](#81-create-your-inventories-files)
- [9. edit inventories files](#9-edit-inventories-files)
- [10. run](#10-run)
- [11. Orginal sample from isam-ansible-playbook-sample:](#11-orginal-sample-from-isam-ansible-playbook-sample)
- [12. Callback plugin:](#12-callback-plugin)

<!-- /TOC -->

# 2. isam-ansible
https://hub.docker.com/r/mludocker/isam-ansible/dockerfile

This will install and config the centos machine for the use of ansible and IBM tools

# 3. OS
- CentOS 7 Supported
- CentOS 8 Supported

# 4. Overview
This script is built on top of CentOS 7, it will install the Ansible and the ISAM Python module, ISAM Ansible module, and ISAM Ansible Roles.

The goal is to allow a user to run ISAM Ansible playbook quickly.

# 5. Pre-Requisites
You need to have a installed CentOS 7 machine.

# 6. Run
Download:
```
git clone https://github.com/CoolZeroNL/isam-ansible.git
```

```
cd isam-ansible
./00-run.sh
```

# 7. Usage
# 8. Usage:
## 8.1. Create your inventories files.
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

# 9. edit inventories files
edit the vars.yml and vault.yml files

# 10. run
```
cd ~/isam-ansible-playbook-sample
ansible-playbook -i ../isam-ansible-inventories/inventories/local base/activate_modules.yml
```


# 11. Orginal sample from isam-ansible-playbook-sample:
```
cd ~/isam-ansible-playbook-sample
ansible-playbook -i inventories/test base/activate_modules.yml
```

# 12. Callback plugin:
This is the debug plugin from ansible, just added field `log` to the key to parse the content.

For each Failed line this plugin will check if there is `headers are`, `input data`, `text` in line. If so, this line will be a other color.