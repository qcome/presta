#!/bin/sh

# Abort on any error (including if wait-for-it fails).
set -e

# Wait for the nginx app to be up, if we know where it is.
if [ -n "$NGINX_HOST" ]; then
  /tmp/wait-for-it.sh --timeout=60 --strict "$NGINX_HOST:${NGINX_PORT:-9000}"
fi

# Run the main container command.
exec "$@"
