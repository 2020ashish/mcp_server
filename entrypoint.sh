#!/bin/sh
set -e

# Default host/port/workers
HOST=${HOST:-0.0.0.0}
PORT=${PORT:-8000}
WORKERS=${WORKERS:-2}

# Optional SSL
SSL_ARGS=""
if [ -n "$SSL_CERT_FILE" ] && [ -n "$SSL_KEY_FILE" ]; then
    SSL_ARGS="--ssl-certfile $SSL_CERT_FILE --ssl-keyfile $SSL_KEY_FILE"
fi

echo "Starting FastMCP server..."
echo "Host: $HOST"
echo "Port: $PORT"
echo "Workers: $WORKERS"
if [ -n "$SSL_ARGS" ]; then
    echo "SSL enabled"
else
    echo "SSL disabled"
fi

# Run Uvicorn
exec uvicorn fastmcp_server:app \
    --host $HOST \
    --port $PORT \
    --workers $WORKERS \
    --log-level info $SSL_ARGS
