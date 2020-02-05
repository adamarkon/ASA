#!/bin/bash
#
# ASA server agent for SUSE - install script
#
#   This is a quick script to install the latest version of ScaleFT (ASA) server agent for SUSE
#
# Download the ScaleFT (ASA) server agent code:
sudo curl -o /tmp/scaleft-server-tools-latest.x86_64.rpm https://dist.scaleft.com/server-tools/linux/latest/scaleft-server-tools-latest.x86_64.rpm
#
# Trust the repository signing key
sudo rpm --import https://dist.scaleft.com/pki/scaleft_rpm_key.asc
#
# Use zypper directly to install
sudo zypper --non-interactive install /tmp/scaleft-server-tools-latest.x86_64.rpm
# Or if preferred, use the (deprecated) yast2 install command:
# sudo yast2 -i /tmp/scaleft-server-tools-latest.x86_64.rpm
