#!/usr/bin/env bash

# extra provisioning
#
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

APP_PATH="/var/www"
SKELETON_VERSION="~0.9"
BLUZMAN_VERSION="~0.2"
PROJECT_NAME="bluz"

if [ ! -f "$APP_PATH/bluz/composer.json" ]; then
    cd $APP_PATH

    composer create-project bluzphp/bluzman="$BLUZMAN_VERSION" ./bluzman --prefer-dist

    su - vagrant -c "cd $APP_PATH/bluzman && sh bin/install.sh"
    export PATH=$PATH:$APP_PATH/bluzman/bin

    bluzman init:all --path $APP_PATH --name $PROJECT_NAME

    ## Copy config files for `dev` environment
    cp /vagrant/files/configs/* /var/www/$PROJECT_NAME/application/configs/dev

    ##
    mysql -uhomestead -psecret $PROJECT_NAME < /var/www/$PROJECT_NAME/structure.ddl;
    mysql -uhomestead -psecret $PROJECT_NAME < /var/www/$PROJECT_NAME/dump.sql;
    mysql -uhomestead -psecret $PROJECT_NAME < /var/www/$PROJECT_NAME/tests/dump.sql;
else
    cd "$APP_PATH/$PROJECT_NAME"

    composer install
fi