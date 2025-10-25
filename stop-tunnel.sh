#!/data/data/com.termux/files/usr/bin/bash

# Stop all running tunnels and HTTP servers

echo "Stopping HTTP servers..."
pkill -f "http.server" 2>/dev/null || true

echo "Stopping Bore tunnels..."
pkill -f "bore local" 2>/dev/null || true

echo "✓ All tunnels stopped"