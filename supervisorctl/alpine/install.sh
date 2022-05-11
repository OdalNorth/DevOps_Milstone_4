#!/bin/sh

apk update && apk add --no-cache postgresql12 supervisor openjdk11 curl

mkdir /var/lib/postgresql/data && chown postgres:postgres /var/lib/postgresql/data
chmod 0700 /var/lib/postgresql/data && mkdir /run/postgresql && chown postgres:postgres /run/postgresql/
su -l postgres -c 'initdb -D /var/lib/postgresql/data'
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/postgresql/data/postgresql.conf

db_user=postgres
db_pass=postgres
db_base=geocitizen
su -l postgres -c 'pg_ctl start -D /var/lib/postgresql/data'
su -l postgres -c "psql -c \"CREATE ROLE $db_user WITH LOGIN;\""
su -l postgres -c "psql -c \"CREATE DATABASE $db_base;\""
su -l postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE $db_base to $db_user;\""
su -l postgres -c "psql -c \"ALTER USER $db_user WITH PASSWORD $db_pass;\""

VERSION=9.0.62
mkdir /opt/tomcat
wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v${VERSION}/bin/apache-tomcat-${VERSION}.tar.gz -P /tmp
tar -xf /tmp/apache-tomcat-${VERSION}.tar.gz -C /opt/tomcat/
ln -s /opt/tomcat/apache-tomcat-${VERSION} /opt/tomcat/latest
chmod +x /opt/tomcat/latest/bin/*.sh

supervisord -c /etc/supervisord.conf
supervisor_name=admin
supervisor_pass=qwe
sed -i "s/;\[inet_http_server\]/[inet_http_server]/g" /etc/supervisord.conf
sed -i "s/;port=127.0.0.1/port=*/g" /etc/supervisord.conf
sed -i "s/;username=user/username=$supervisor_name/g" /etc/supervisord.conf
sed -i "s/;password=123/password=$supervisor_pass/g" /etc/supervisord.conf
mkdir /etc/supervisor.d