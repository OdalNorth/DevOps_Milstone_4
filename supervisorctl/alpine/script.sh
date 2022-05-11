#!/bin/bash

#initialization credential variable

mail=your_mail
mail_password=your_pass

server_app="your_ip"
server_db="localhost"
name_db="geocitizen"

echo "Fix dependencies"

# Fix pom.xml for mvn install

sed -i "s/>servlet-api/>javax.servlet-api/g" Geo/pom.xml
sed -i -E "s/(http:\/\/repo.spring)/https:\/\/repo.spring/g" Geo/pom.xml
sed -i "/<distributionManagement>/,/<\/distributionManagement>/d" Geo/pom.xml

# Fix application.properties for url and db ip

sed -i -E "s/ss_demo_1/$name_db/g" Geo/src/main/resources/application.properties
sed -i "s/http:\/\/localhost/http:\/\/$server_app/g" Geo/src/main/resources/application.properties
sed -i "s/postgresql:\/\/35.204.28.238/postgresql:\/\/$server_db/g" Geo/src/main/resources/application.properties
sed -i "s/ssgeocitizen@gmail.com/$mail/g" Geo/src/main/resources/application.properties
sed -i "s/=softserve/=$mail_password/g" Geo/src/main/resources/application.properties

# Fix front-end

sed -i "s/\/src\/assets/\.\/static/g" Geo/src/main/webapp/index.html

sed -i "s/localhost/$server_app/g" Geo/src/main/java/com/softserveinc/geocitizen/configuration/MongoConfig.java   
sed -i "s/localhost/$server_app/g" Geo/src/main/webapp/static/js/app.6313e3379203ca68a255.js
sed -i "s/localhost/$server_app/g" Geo/src/main/webapp/static/js/app.6313e3379203ca68a255.js.map
sed -i "s/localhost/$server_app/g" Geo/src/main/webapp/static/js/vendor.9ad8d2b4b9b02bdd427f.js
sed -i "s/localhost/$server_app/g" Geo/src/main/webapp/static/js/vendor.9ad8d2b4b9b02bdd427f.js.map

echo "Building project"

(ls)

(cd Geo; eval mvn install)
