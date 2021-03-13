#!/bin/sh

# Abort on any error (including if wait-for-it fails).
set -e
echo "TESTTTT"
echo "$@"

# Wait for the nginx app to be up, if we know where it is.
if [ -n "$APP_HOST" ]; then
  /tmp/wait-for-it.sh --timeout=60 --strict "$APP_HOST:${APP_PORT:-9000}" -- "$RUN_INSTALL" "$APP_NAME"
fi

# Run the main container command.
exec "$@"
