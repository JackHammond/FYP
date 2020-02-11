#!/bin/bash

						#nodejs backend setup
function back-end(){

#OAUTH_TOKEN='ff452dfb5f8c421641791e7f40e576920845d8b1'

#sudo apt update

#sudo apt install git

#sudo git clone https://$OAUTH_TOKEN:x-oauth-basic@github.com/JackHammond/FYP.git

cd ~

sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

sudo apt install nodejs

sudo apt install -y mongodb

cd ~

cd FYP/Monolithic/mono_flutter_back_end/ 

sudo npm install

sudo npm install forever -g

sudo npm install forever-monitor

sudo forever start src/index.js
}

						#flutter nginx setup

function front-end() {

curl http://localhost:4000/api/catalog/delete

curl http://localhost:4000/api/catalog/create

curl http://localhost:4000/api/catalog/

#alias front='cd ~/FYP/Monolithic/mono_flutter_front_end/'

#front

sudo apt-get clean

sudo apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3

sudo apt-get clean

sudo git clone https://github.com/flutter/flutter.git /usr/local/flutter

cd ~

cd FYP/Monolithic/mono_flutter_front_end/ 

/usr/local/flutter/bin/flutter doctor -v

export PATH="$PATH:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

sudo chown -R $USER:$USER /usr/local/flutter/

sudo chown -R $USER:$USER . 

flutter channel master

flutter upgrade

flutter config --enable-web


cd ~

cd FYP/Monolithic/mono_flutter_front_end/ 

/usr/local/flutter/bin/flutter build web

sudo apt install nginx

sudo cp -r build/web/* /var/www/html/

sudo cp -r build/web/* /usr/share/nginx/html/

sudo systemctl start nginx
}
