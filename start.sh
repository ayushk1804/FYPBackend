#!/bin/sh
apt-get update
export DEBIAN_FRONTEND=noninteractive
apt-get -y install tzdata
echo "Asia/Kolkata" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
apt-get install -y openjdk-8-jdk
apt-get install -y gnupg
apt-get install -y wget
apt-get install -y sudo
apt-get install -y systemctl
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
mongod --bind_ip 0.0.0.0 & java -server -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:InitialRAMFraction=2 -XX:MinRAMFraction=2 -XX:MaxRAMFraction=2 -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -jar demo.jar
