#!/bin/bash
set -e

mkdir -p /run/php

#lance php-fpm en premier plan
php-fpm8.2 -F
