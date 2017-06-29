#!/bin/bash

#set -e

echo "Installing Ansible  on CentOS..." 

A=`yum info ansible`

testing=`[[ $A =~ 'Ansible' ]]`

echo $testing

echo  "############# ${testing} ##############"
timedatectl set-timezone Asia/Taipei

 
if [[ $testing != ""  ]]; then
     echo "Ansible is already installed."
else
      echo "Ansible is not installed."
      yum install -y wget
      wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
      rpm -ivh  epel-release-7-9.noarch.rpm
      rm -rf epel-release-7-9.noarch.rpm
      
fi

yum  install -y ansible


cp /vagrant/ansible/ansible.cfg /etc/ansible/ansible.cfg

yum update -y

#yum groupinstall  -y "X Window System"
#yum  install -y gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts
#yum  install -y xrdp tigervnc-server
#systemctl enable xrdp.service
#chcon --type=bin_t /usr/sbin/xrdp
#chcon --type=bin_t /usr/sbin/xrdp-sesman
#systemctl restart xrdp.service

# unlink /etc/systemd/system/default.target
# ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
