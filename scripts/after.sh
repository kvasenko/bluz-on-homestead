#!/usr/bin/env bash

# extra provisioning
#
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

APP_PATH="/var/www"
SKELETON_VERSION="~0.9"
PROJECT_NAME="bluz"

if [ ! -f "$APP_PATH/bluz/composer.json" ]; then
    cd $APP_PATH

    composer create-project bluzphp/skeleton="$SKELETON_VERSION" ./$PROJECT_NAME --prefer-dist
else
    cd "$APP_PATH/$PROJECT_NAME"

    composer install
fi