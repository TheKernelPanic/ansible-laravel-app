#!/bin/bash

if [ ! -f ~/release.tar.gz ];then
exit 0
fi

sudo systemctl stop php{{VERSION}}-fpm

if [ $(ls "/var/www/{{DIRNAME}}" | wc -l) != 0 ]; then
sudo rm -R /var/www/{{DIRNAME}}/*
fi

sudo tar -xf ~/release.tar.gz --strip 1 -C /var/www/{{DIRNAME}}/

sudo ln -s /var/www/storage /var/www/{{DIRNAME}}/storage

sudo chown -R www-data:{{GROUP}} /var/www/{{DIRNAME}}/*

sudo systemctl start php{{VERSION}}-fpm

rm ~/release.tar.gz

sudo -u www-data php /var/www/{{DIRNAME}}/artisan storage:link
