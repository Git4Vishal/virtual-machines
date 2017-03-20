#!/bin/sh
# Disable SELinux
setenforce 0

# Install java-1.8
yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel
# yum -y install gcc make kernel kernel-devel
yum -y install docker*
yum -y install net-tools
# rcvboxdrv setup

# set /etc/hosts
echo '127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4' > /etc/hosts
echo '::1 localhost localhost.localdomain localhost6 localhost6.localdomain6' >> /etc/hosts
echo '192.168.199.2 node1.example.com' >> /etc/hosts
echo '192.168.199.3 node2.example.com' >> /etc/hosts
echo '192.168.199.4 node3.example.com' >> /etc/hosts
echo '192.168.199.5 node4.example.com' >> /etc/hosts

# jps fix
ln -s /usr/bin/jps /usr/lib/jvm/jre//bin/jps

# fix jar
ln -s /usr/bin/jar /usr/lib/jvm/jre/bin/jar

# install ntp
yum -y install ntp
systemctl enable ntpd
service ntpd start

# install deltarpm
yum install -y deltarpm

# fix DOWN interfaces - bug in centos7 box
DOWNIF=`ip addr |grep DOWN |cut -d ' ' -f2 |cut -d ':' -f1`
DOWNIFCHECK=`ip addr |grep DOWN |cut -d ' ' -f2 |cut -d ':' -f1 |wc -l`
if [ $DOWNIFCHECK == 1 ] ; then
  ifdown $DOWNIF
  ifup $DOWNIF
fi