# Milestone 4
Table of contents 
- [Terratest](#terratest)
- [SupervisorCTL](#supervisorCTL)

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