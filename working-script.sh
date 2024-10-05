#!/bin/bash -xe
sudo dpkg --configure -a
apt update -y
apt install nodejs unzip wget npm mysql-client awscli -y
#wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-200-ACCAP1-1-DEV/code.zip -P /home/ubuntu
wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-200-ACCAP1-1-79581/1-lab-capstone-project-1/code.zip -P /home/ubuntu
cd /home/ubuntu
unzip code.zip -x "resources/codebase_partner/node_modules/*"
cd resources/codebase_partner
npm install aws aws-sdk
# Modify app config
chmod +wr app/config/config.js
echo 'let config = {
  APP_DB_HOST: "database-1.c6s6drcsqs9l.us-east-1.rds.amazonaws.com",
  APP_DB_USER: "moodeng",
  APP_DB_PASSWORD: "moodeng_zoo24",
  APP_DB_NAME: "STUDENTS"
}
module.exports = config;' > app/config/config.js
export APP_PORT=8080
npm start &
echo '#!/bin/bash -xe
cd /home/ubuntu/resources/codebase_partner
export APP_PORT=8080
npm start' > /etc/rc.local
chmod +x /etc/rc.local