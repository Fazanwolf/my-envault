#!/bin/bash

tmp=$(echo $(heroku pg:credentials:url))

DB_DATABASE=$(echo $tmp | cut -d' ' -f9 | cut -d= -f2)
DB_HOST=$(echo $tmp | cut -d' ' -f10 | cut -d= -f2)
DB_PORT=$(echo $tmp | cut -d' ' -f11 | cut -d= -f2)
DB_USERNAME=$(echo $tmp | cut -d' ' -f12 | cut -d= -f2)
DB_PASSWORD=$(echo $tmp | cut -d' ' -f13 | cut -d= -f2)
DATABASE_URL=$(echo $tmp | cut -d' ' -f17)

heroku config:add DATABASE_URL=$DATABASE_URL
heroku config:add DB_CONNEXION=pgsql
heroku config:add DB_DATABASE=$DB_DATABASE
heroku config:add DB_HOST=$DB_HOST
heroku config:add DB_PORT=$DB_PORT
heroku config:add DB_USERNAME=$DB_USERNAME
heroku config:add DB_PASSWORD=$DB_PASSWORD