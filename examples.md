# Usage:
## Create your inventories files.
```
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

