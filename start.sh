#!/bin/sh
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install tzdata
echo "Asia/Kolkata" | tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata
sudo apt-get install -y openjdk-8-jdk
sudo apt-get install -y gnupg
sudo apt-get install -y wget
sudo apt-get install -y sudo
sudo apt-get install -y systemctl
sudo wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl daemon-reload
sudo systemctl start mongod
java -server -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:InitialRAMFraction=2 -XX:MinRAMFraction=2 -XX:MaxRAMFraction=2 -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -jar demo.jar
