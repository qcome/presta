
mysql <<EOF
GRANT ALL PRIVILEGES ON 'prestashop' TO 'mysqld'
GRANT ALL PRIVILEGES ON 'prestashop' TO 'username'
FlUSH PRIVILEGES;
EOF