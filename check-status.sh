#!/data/data/com.termux/files/usr/bin/bash

# Check status of HTTP server and tunnel

echo "======================================"
echo "  Tunnel Status Check"
echo "======================================"
echo ""

echo "HTTP Server:"
if pgrep -f "http.server" > /dev/null; then
    echo "  ✓ Running"
    pgrep -af "http.server"
else
    echo "  ✗ Not running"
fi

echo ""
echo "Bore Tunnel:"
if pgrep -f "bore local" > /dev/null; then
    echo "  ✓ Running"
    pgrep -af "bore local"
else
    echo "  ✗ Not running"
fi

echo ""
echo "Server Log (last 10 lines):"
if [ -f /tmp/http-server.log ]; then
    tail -n 10 /tmp/http-server.log
else
    echo "  No log file found"
fi