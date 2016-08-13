#!/bin/bash

# install epel
sudo rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo yum localinstall -y epel-release-6-8.noarch.rpm

# install sshpass(noninteractive ssh password provider)
sudo yum install -y sshpass

# create .ssh directory
if [[ ! -f ~/.ssh ]]; then
  mkdir -p ~/.ssh
fi

# generate rsa key
if [[ ! -f ~/.ssh/id_rsa ]]; then
  ssh-keygen -t rsa -q -f ~/.ssh/id_rsa -P ""
fi

# copy rsa key
cat ~/.ssh/id_rsa.pub | sshpass -p "vagrant" ssh -o StrictHostKeyChecking=no vagrant@192.168.33.101 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

# install python-simplejson (required for ansible)
sudo yum install -y python-simplejson

# install ansible
sudo yum install -y ansible

# configure host for ansible
cat <<EOF > hosts
[provision_serv]
192.168.33.101
EOF

# test connect
ansible -i hosts provision_serv -m ping