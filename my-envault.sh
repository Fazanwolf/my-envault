#!/bin/bash

source .tool.sh

echo "Step 1/6: Check requirement installation"
getOS
case $engine in
    Ubuntu) checkRequirement;;
    Fedora) checkRequirement;;
    Mac) checkRequirement;;
    *) echo "Sorry!! my-envault.sh does not support your operating system. See the README.md to try your installation by your own."
esac

if [[ $# -eq 2 ]]; then
    NAME="$1"
else
    NAME="my-envault-app"
fi

echo "Step 2/6: Importing application"
cd ../
git clone git@github.com:envault/envault.git
mkdir $NAME
cd envault
cp -rf `ls -A | grep -v ".git"` ../$NAME
cp -rf .gitignore .github ../$NAME
cd ../$NAME
rm -rf ../envault

echo "Step 3/6: Initialize installation"
git init
touch Procfile
echo "web: vendor/bin/heroku-php-apache2 public/" > Procfile
cp .env.example .env
sed -i 's/mysql/pgsql/' .env
sed -i "s/'default' => env('DB_CONNECTION', 'mysql')/'default' => env('DB_CONNECTION', 'pgsql')/" config/database.php

heroku create $NAME --region=eu
composer clearcache
composer require laravel/sail:* --dev
composer update --ignore-platform-reqs
php artisan key:generate

echo "Step 4/6: Setup Heroku App"
heroku config:add APP_DEBUG=true
heroku config:add APP_NAME=Envault

MY_URL=$(heroku info -s | grep web_url | cut -d= -f2)
heroku config:add APP_URL=$MY_URL

MY_KEY=$(cat .env | grep "APP_KEY" | cut -d= -f2)
heroku config:add APP_KEY=$MY_KEY

echo "Step 5/6: Setup Heroku postgresql"
heroku addons:create heroku-postgresql:hobby-dev

tmp=$(echo $(heroku pg:credentials:url))
DATABASE_URL=$(echo $tmp | cut -d' ' -f17)
DB_DATABASE=$(echo $tmp | cut -d' ' -f9 | cut -d= -f2)
DB_HOST=$(echo $tmp | cut -d' ' -f10 | cut -d= -f2)
DB_PORT=$(echo $tmp | cut -d' ' -f11 | cut -d= -f2)
DB_USERNAME=$(echo $tmp | cut -d' ' -f12 | cut -d= -f2)
DB_PASSWORD=$(echo $tmp | cut -d' ' -f13 | cut -d= -f2)

heroku config:add DATABASE_URL=$DATABASE_URL
heroku config:add DB_CONNEXION=pgsql
heroku config:add DB_DATABASE=$DB_DATABASE
heroku config:add DB_HOST=$DB_HOST
heroku config:add DB_PORT=$DB_PORT
heroku config:add DB_USERNAME=$DB_USERNAME
heroku config:add DB_PASSWORD=$DB_PASSWORD

echo "Step 6/6: Finish script installation"
git add .
git commit -m "[Initialization]"
git push heroku master

heroku run php artisan migrate

echo "Hold up! That not finish, you need to follow 'script_installation.md'"