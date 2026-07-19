#!/bin/bash
# Create Jenkins user
if ! id jenkins &>/dev/null; then
  groupadd -g 752 jenkins
  useradd -m -u 752 -g jenkins -d /home/jenkins -s /bin/bash -c "LOCAL JENKINS USER" jenkins
fi
# Setup SSH Passwordless authentication for Jenkins
mkdir -p /home/jenkins/.ssh
chmod 700 /home/jenkins/.ssh

cat > /home/jenkins/.ssh/authorized_keys <<'EOF'
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzvYYBFadhO8RL5iNib1DdaotuRXm2w3KF1xm4jmJtnV2qMCOwDPl+8vFQheCGFFi1YdJ/g1lmTz3DXjL4cOnScy/hapjWa8rq49uvwup7biUpAFy0rBep3fz7MBlxoKdbSu/GwIicTYf/mgGHhoeqfPheV1kx7aIPTMiAQay4rFpOnlaDEh0xF1yB50KURzJcf2BM3jAlM26fLYITwrZLUJmgjr2ZQ/Svm4mMu1fRywwDQd7kcY8zrRvpRNCW+nsogGlCcbMwpU1WPlPZ3MdumdnMGt0qnCp4Ci726qWAJNhVTt1xD7izqsVUk5Be/PliKotfMlE2cOIDEiyWtbH1oSO8+WzvqCMalvR2qz0r4px/xtW9Osc5WF6MGcJVW6rjV908wQKIuTkkYAWsfk79L4MBv/L9MV2s3KFo7KXe1PsrC/JBt661xGrdLE8Tkir6k5dR3CqwSv6gB1aUcWSMqM8NzW+n00h8aLc5BSFXVnezNvrkKB3HgE0dMNU7A8= jenkins@w360jenkinsgcp
EOF

chmod 600 /home/jenkins/.ssh/authorized_keys
chown -R jenkins:jenkins /home/jenkins/.ssh