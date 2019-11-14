#!/bin/bash

# install in home dir.
cd ~

    # Centos check
    version=`rpm --eval '%{centos_ver}'`

    if [ "$version" -eq "7" ]; then
        echo "version 7"
    elif [ "$version" -eq "8" ]; then
        echo "version 8"
        yum install -y dnf-plugins-core
        yum config-manager --set-enabled PowerTools
    else
        echo "No Centos 7 or 8 found"
        exit 1
    fi

# Install OS pre-requisites
yum -y update; yum clean all
yum -y install epel-release; yum clean all
yum -y install nano unzip gcc curl openssl-devel git openssh-clients; yum clean all
yum -y install python3 python3-pip python3-devel ; yum clean all

# Install/Update Python modules
pip3 install --upgrade pip requests ansible python3-ldap pygments
pip install --upgrade git+https://github.com/ibm-security/ibmsecurity#egg=ibmsecurity

# Remove packages to save space
# yum -y remove epel-release gcc openssl-devel

# Prepare Ansible environment
mkdir /etc/ansible/ /ansible /etc/ansible/roles/
echo "[local]" >> /etc/ansible/hosts
echo "localhost" >> /etc/ansible/hosts

mkdir -p /ansible/playbooks

# Prepare ISAM Ansible Common Roles 
ansible-galaxy install -c -p /etc/ansible/roles git+https://github.com/ibm-security/isam-ansible-roles.git 

# Prepare ISDS Ansible Common Roles 
ansible-galaxy install -c -p /etc/ansible/roles git+https://github.com/IBM-Security/isds-ansible-roles.git

if [[ -z "${ANSIBLE_ROLES_PATH}" ]]; then
  
  echo 'ANSIBLE_GATHERING=smart' >> /etc/bashrc
  echo 'ANSIBLE_HOST_KEY_CHECKING=false' >> /etc/bashrc
  echo 'ANSIBLE_RETRY_FILES_ENABLED=false' >> /etc/bashrc
  echo 'ANSIBLE_ROLES_PATH=/etc/ansible/roles/isam-ansible-roles' >> /etc/bashrc
  # echo 'ANSIBLE_ROLES_PATH=/etc/ansible/roles/isds-ansible-roles:$ANSIBLE_ROLES_PATH' >> /etc/bashrc
  echo 'DEFAULT_ROLES_PATH=/etc/ansible/roles/isam-ansible-roles:$DEFAULT_ROLES_PATH' >> /etc/bashrc
  # echo 'ANSIBLE_ROLES_PATH=/etc/ansible/roles/isds-ansible-roles:$ANSIBLE_ROLES_PATH' >> /etc/bashrc  
  echo 'ANSIBLE_SSH_PIPELINING=True' >> /etc/bashrc
  echo 'PYTHONPATH=/ansible/lib' >> /etc/bashrc
  echo 'PATH=/ansible/bin:$PATH' >> /etc/bashrc

  echo "Done loading rules into: /etc/bashrc"
else
  echo "rules already exists in: /etc/bashrc"
fi

# To load the new environment variables into the current shell session use the source command:
source ~/.bashrc

cd 
git clone https://github.com/IBM-Security/isam-ansible-playbook-sample.git

# copy ansible play config
cp isam-ansible/ansible.cfg isam-ansible-playbook-sample/

# install plugin: for callback
cp isam-ansible/ansible_callback_plugin/debug_custom.py /usr/local/lib/python3.6/site-packages/ansible/plugins
