#!/bin/sh

# Abort on any error (including if wait-for-it fails).
set -e

# Wait for the db to be up, if we know where it is.
if [ -n "$DB_HOST" ]; then
  /tmp/wait-for-it.sh --timeout=60 --strict "$DB_HOST:${DB_PORT:-3306}" -- /tmp/run_install_prestashop.sh
fi

# Run the main container command.
exec "$@"
