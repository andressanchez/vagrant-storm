#/bin/bash

# 1. Install unzip and supervisor
sudo apt-get update
sudo apt-get install -y unzip supervisor
sudo /etc/init.d/supervisor stop

# 2. Add a new user for storm
sudo groupadd storm
sudo useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm

# 3. Install storm from zip
sudo wget http://www.eu.apache.org/dist/incubator/storm/apache-storm-0.9.2-incubating/apache-storm-0.9.2-incubating.zip
sudo unzip -o apache-storm-0.9.2-incubating.zip -d /usr/share
sudo chown -R storm:storm /usr/share/apache-storm-0.9.2-incubating
sudo ln -s /usr/share/apache-storm-0.9.2-incubating /usr/share/storm
sudo ln -s /usr/share/storm/bin/storm /usr/bin/storm

# 4. Change log directory
sudo mkdir /var/log/storm
sudo chown storm:storm /var/log/storm
sudo sed -i 's/${storm.home}\/logs/\/var\/log\/storm/g' /usr/share/storm/logback/cluster.xml

# 5. Move storm configuration files
sudo mkdir /etc/storm
sudo chown storm:storm /etc/storm

sudo cp /vagrant/conf/hosts /etc/
sudo cp /vagrant/conf/storm.yaml /etc/storm/
sudo rm /usr/share/storm/conf/storm.yaml
sudo ln -s /etc/storm/storm.yaml /usr/share/storm/conf/storm.yaml