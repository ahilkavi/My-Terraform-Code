#!/bin/bash

##
## Setup GCLOUD on the VM 
##

gcloud.install() {
    ## For info: https://cloud.google.com/sdk/docs/install#rpm
    set -e
    tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
    dnf install -y libxcrypt-compat.x86_64 google-cloud-cli
}

if ! command -v gcloud &> /dev/null; then
	# install
	gcloud.install
else 
	echo "Skipping, gcloud already installed."
fi
gcloud version

# End Gloud Setup

##
## 3) Enable Journal
## Configure VM to preserve system logs after a reboot
##
if [ -f /etc/systemd/journald.conf ]; then
  if ! grep -q "^Storage=persistent" /etc/systemd/journald.conf; then
    sed -i '/\[Journal\]/a Storage=persistent' /etc/systemd/journald.conf
  else
    echo "Storage=persistent already set, skipping"
  fi
else
  echo "Config file not found, skipping"
fi
# End Of Enable Journal

##
## 4) Check / install VM Manager
##
vm.manager.install() {

	# Enable OS API
	gcloud services enable osconfig.googleapis.com
	
	# Install OS Configure Agent
	dnf -y install google-osconfig-agent
	
	# Setup metadata enable-osconfig=TRUE
}

# check if VM Manager installed/enabled
#sudo systemctl status google-osconfig-agent
if [ ! $? != 0 ]; then
	vm.manager.install
else	
	echo "Skipping, VM Manager already installed."
fi

# End of VM Manager
##
## 5) tmp clean script
##
tmpfile_conf="/etc/tmpfiles.d/tmp-logs.conf"
tmpfile_content="d /tmp - - - 15d"

# ensure tmpfiles.d directory exist
if [ ! -d /etc/tmpfiles.d ]; then
   mkdir -p /etc/tmpfiles.d
   echo "tmpfiles.d directory created"
fi
# create or append the conf file
if [ ! -f "$tmpfile_conf" ]; then
   echo "$tmpfile_content" > "$tmpfile_conf"
   echo "tmpfile conf created and updated with 15d policy"
else
 # append only if same line not exist"
   if ! grep -Fxq "$tmpfile_content" "$tmpfile_conf"; then
      echo "$tmpfile_content" >> "tmpfile_conf"
	  echo "appended the line in conf file"
 else
    echo "same policy defined in tmpconf file so skipping"
   fi
fi
# tmp clean script