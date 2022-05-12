# Milestone 4
Table of contents 
- [Terratest](#terratest)
- [SupervisorCTL](#supervisorCTL)
- [SonarQube](#sonarQube)

# Terratest

Official page project Test infrastructure code with Terratest (include simple examples)  -> [gruntwork](https://terratest.gruntwork.io/)

Simple guide for testing infrastructure-as-code with Terratest -> [youtube](https://www.youtube.com/watch?v=GLhtnOdSIh0)

Official github repo with terratest modules -> [gihub](https://github.com/gruntwork-io/terratest/tree/master/modules)

Official github repo with more examples -> [gihub](https://github.com/gruntwork-io/terratest/tree/master/modules)

Commands for Go:

  ```bash
  # need for create go.mod file
  $ go mod init mod

  # needed to download required modules
  $ go get -t -v

  # run Go-test script
  # -v flag for verbose output
  $ go test -v <name-of-file>.go
  ```
_________________________________________________________________________________________________
# SupervisorCTL
Official documetation -> [supervisord.org](http://supervisord.org/index.html#)

Basic guide for installation and manage supervisorctl -> [digitalocean.com](https://www.digitalocean.com/community/tutorials/how-to-install-and-manage-supervisor-on-ubuntu-and-debian-vps)

## Dockerfile
My example Dockerfile -> [gihub](https://github.com/OdalNorth/DevOps_Milstone_4/blob/main/supervisorctl/alpine/Dockerfile)

## Requirements files for Dockerfile
File for installation postgresql into container -> [gihub](https://github.com/OdalNorth/DevOps_Milstone_4/blob/main/supervisorctl/alpine/install.sh)
Script for Supervisor to start PostgreSQL in foreground mode -> [gihub](https://github.com/OdalNorth/DevOps_Milstone_4/blob/main/supervisorctl/alpine/postgres_service.sh)
- Explanation why this script is needed [localcoder.org](https://localcoder.org/running-postgresql-with-supervisord)
Conf file (*.ini) for Supervisor running and output in log files -> [gihub](https://github.com/OdalNorth/DevOps_Milstone_4/blob/main/supervisorctl/alpine/supervisord.ini)

Helper file to build the application (optional) [github](https://github.com/OdalNorth/DevOps_Milstone_4/blob/main/supervisorctl/alpine/script.sh)

## Commands

Commands for building and managing Geo Citizen Docker image whith supervisor:

- for **alpine** based:

  ```bash
  # Docker build
  # DOCKER_BUILDKIT=1 needed to execute the command --chmod=777
  $ DOCKER_BUILDKIT=1 docker build . -t supervisor_geo
  # Docker run
  $ docker run --name supervisor_geo -p 9001:9001 -p 8080:8080 -d supervisor_geo:latest
  ```
# SonarQube

## SonarQube prepares

Official Sonarqube documentation -> [docs.sonarqube](https://docs.sonarqube.org/latest/)
Official Sonarqube repo with packages -> [binaries.sonarsource](https://binaries.sonarsource.com/?prefix=Distribution/sonarqube/)

Sonarqube installation:

  ```bash
  # update system
  $ sudo apt-get update && sudo apt-get -y upgrade
  
  # openjdk installation
  $ sudo apt install openjdk-11-jdk

  # add PostgreSQL repo
  $ sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
  $ wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -

  # install PostgreSQL
  $ sudo apt -y install postgresql postgresql-contrib

  # check postgres service
  $ sudo systemctl status postgresql.service

  $ sudo -i -u postgres psql
  ```

  ```sql
  # ALTER ROLE postgres WITH PASSWORD 'your_pass';
  # ALTER USER sonar WITH ENCRYPTED password 'your_pass';
  # CREATE DATABASE sonar OWNER sonar;
  # GRANT ALL PRIVILEGES ON DATABASE sonar TO sonar;
  # \q
  ```

  ```bash
  
  # download SonarQube
  $ wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.4.0.54424.zip

  # installation
  $ sudo apt install unzip
  $ sudo unzip sonarqube-9.4.0.54424.zip -d /opt/
  $ sudo mv /opt/sonarqube-9.4.0.54424/ /opt/sonarqube
  
  # configure sonar user
  $ sudo groupadd sonar
  $ sudo useradd -d /opt/sonarqube -g sonar sonar
  $ sudo chown sonar:sonar /opt/sonarqube -R

  # change properties of SonarQube
  $ sudo nano /opt/sonarqube/conf/sonar.properties
  ```

  ```ini
  # sonar.properties
  sonar.jdbc.username=sonar
  sonar.jdbc.password=sonar_pass
  ...
  sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube
  ...
  sonar.web.javaAdditionalOpts=-server
  ```

  ```bash
  # edit SonarQube script
  $ sudo nano /opt/sonarqube/bin/linux-x86-64/sonar.sh
  ```

  ```sh
  # sonar.sh
  RUN_AS_USER=sonar
  ```

  ```bash
  # create service SonarQube
  $ sudo nano /etc/systemd/system/sonar.service
  ```

  ```ini
  # sonar.service
  [Unit]
  Description=SonarQube service
  After=syslog.target network.target

  [Service]
  Type=forking

  ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
  ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop

  User=sonar
  Group=sonar
  Restart=always

  [Install]
  WantedBy=multi-user.target
  ```

  ```bash
  # start + enable SonarQube
  $ sudo systemctl enable --now sonar.service

  # changes due to usage ElasticSearch by SonarQube
  $ sudo nano /etc/sysctl.conf
  ```

  ```ini
  # in sysctl.conf file

  ###################################################################
  # change sysctl.conf file for SonarQube due to ElasticSearch
  vm.max_map_count=262144
  fs.file-max=65536
  ulimit -n 65536
  ulimit -u 4096
  ```

Chech access web interfacec of SonarQube on http://public-ip-of-VM:9000/  
Default credeantials: *login = admin, pass = admin* 

## PostgreSQL configuration for Geocit134

Create user and DBs for Geocit134 tests:

  ```bash
  $ sudo -i -u postgres psql
  ```

  ```sql
  # CREATE USER geocitizen WITH PASSWORD 'your_pass';
  # ALTER USER geocitizen CREATEDB;
  # CREATE DATABASE geo;
  # CREATE DATABASE geo_test;
  # GRANT ALL PRIVILEGES ON DATABASE geo to geocitizen;
  # GRANT ALL PRIVILEGES ON DATABASE geo_test to geocitizen;
  ```

Change pg_hba.conf:

  ```bash
  $ sudo nano /etc/postgresql/12/main/pg_hba.conf
  ```

  ```ini
  # pg_hba.conf
  local   all             all                              md5
  ```

Run Sonarqube:
  ```bash
  $ mvn clean verify sonar:sonar -Dsonar.login=<only-token>
  ```