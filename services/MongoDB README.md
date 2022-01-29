### Installing MongoDB on Ubuntu ###
# Import MongoDB public GPG Key #
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -

# create list file for MongoDB #
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

# reload local package database #
sudo apt-get update

# install mongoDB packages # 
sudo apt-get install -y mongodb-org

# user #
 - default user is 'mongodb' user account
 - if user is changed, must also cahange permissions to data and log directories
  - data: /var/lib/mongodb
  - log: /var/log/mongodb

# config # 
 - /etc/mongod.conf included on creation
 - any changes and must restart MongoDB

# start mongoDB # 
sudo systemctl start mongod

# verify running #
sudo systemctl status mongod

# stop mongo #
sudo systemctl stop mongod

# restrat #
sudo systemctl restart mongod

# use MongoDB shell#
mongosh

# install mongo package #
npm install mongodb

# require mongo pacakage in node #
var mongo = require('mongodb');

