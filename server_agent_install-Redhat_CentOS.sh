#! /bin/bash

echo "Add an enrollment token"

sudo mkdir -p /var/lib/sftd

# get enrollment token from app.scaleft.com
# Be sure to replace the <<REPLACE WITH YOUR ENROLLMENT TOKEN>> variable below with your
# enrollment token

echo "<<REPLACE WITH YOUR ENROLLMENT TOKEN>>" | sudo tee /var/lib/sftd/enrollment.token

export DEBIAN_FRONTEND=noninteractive

# Add the ScaleFT yum repository
echo "Add the ScaleFT yum repository"
curl -C - https://pkg.scaleft.com/scaleft_yum.repo | sudo tee /etc/yum.repos.d/scaleft.repo

# Trust the repository signing key
sudo rpm --import https://dist.scaleft.com/pki/scaleft_rpm_key.asc

#echo "Retrieve information about new packages"
#sudo yum update

echo "Install sftd"
sudo yum -y install scaleft-server-tools
