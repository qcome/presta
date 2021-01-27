mysqld <<EOF
GRANT ALL PRIVILEGES ON 'prestashop' TO 'mysqld';
FlUSH PRIVILEGES;
EOF