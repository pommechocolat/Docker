#!/bin/bash

echo "startup MariaDB / Mysql"

echo "192.168.59.103 sql.lautre.net" >> /etc/hosts
echo "<?php phpinfo();" > /var/www/html/info.php

/usr/sbin/apache2ctl -D FOREGROUND
