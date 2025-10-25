#!/data/data/com.termux/files/usr/bin/bash

# Quick start script - assumes setup is already complete
# Usage: ./start-tunnel.sh [port]

PORT=${1:-8080}

echo "Starting HTTP server on port $PORT..."
pkill -f "http.server $PORT" 2>/dev/null || true
python -m http.server $PORT > /tmp/http-server.log 2>&1 &

sleep 2

echo ""
echo "Starting Bore tunnel..."
echo "Press Ctrl+C to stop"
echo ""

export PATH="$HOME/.cargo/bin:$PATH"
bore local $PORT --to bore.pub