#!/bin/bash
if ! id jenkins &>/dev/null; then
  groupadd -g 752 jenkins
  useradd -m -u 752 -g jenkins -d /home/jenkins -s /bin/bash -c "LOCAL JENKINS USER" jenkins
fi
# Setup SSH Passwordless authentication for Jenkins
mkdir -p /home/jenkins/.ssh
chmod 700 /home/jenkins/.ssh
# add only if same key not exist"
if ! grep -Fxq "${jenkins_pub_key_content}" "/home/jenkins/.ssh/authorized_keys"; then
cat >> /home/jenkins/.ssh/authorized_keys <<EOF
${jenkins_pub_key_content}
EOF
else
    echo "same key already there in authorized_keys"
   fi
chmod 600 /home/jenkins/.ssh/authorized_keys
chown -R jenkins:jenkins /home/jenkins/.ssh