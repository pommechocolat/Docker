#!/bin/bash

echo "startup MariaDB / Mysql"

echo "192.168.99.100 sql.lautre.net" >> /etc/hosts
echo "<?php phpinfo();" > /var/www/html/info.php

/usr/sbin/apache2ctl -D FOREGROUND
