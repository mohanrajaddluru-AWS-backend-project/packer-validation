sleep 30
sudo apt update
sudo apt install nodejs
sudo node -v
sudo apt install npm
sudo apt install curl
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs
node -v
npm -v

sudo apt-get install mariadb-server unzip -y

sudo systemctl start mysql
sudo systemctl enable mysql
sudo systemctl status mysql
sudo apt-get install expect

expect <<EOF
set timeout -1
spawn sudo mysql_secure_installation

expect "Enter current password for root (enter for none):"
send "\r"

expect "Set root password? [Y/n]"
send "n\r"

expect "Remove anonymous users? [Y/n]"
send "n\r"

expect "Disallow root login remotely? [Y/n]"
send "n\r"

expect "Remove test database and access to it? [Y/n]"
send "n\r"

expect "Reload privilege tables now? [Y/n]"
send "Y\r"

expect eof
EOF

#sudo mysql -u root -e "CREATE USER 'test'@'127.0.0.1' IDENTIFIED BY ' '; GRANT CREATE, ALTER, DROP, INDEX, INSERT, SELECT, UPDATE, DELETE, CREATE TEMPORARY TABLES, LOCK TABLES ON *.* TO 'test'@'127.0.0.1'; GRANT ALL PRIVILEGES ON *.* TO 'test'@'127.0.0.1'; FLUSH PRIVILEGES;",
sudo mysql -u root -e "CREATE DATABASE test;"
sudo mysql -u root -e "SHOW DATABASES";

sudo pwd

echo "below are current repo folders"

sudo ls -ltrh


cd ~/ && unzip webapp.zip
cd ~/webapp && npm i


sudo mv /tmp/webapp.service /etc/systemd/system/webapp.service

sudo systemctl enable webapp.service

sudo systemctl start webapp.service
