#!/data/data/com.termux/files/usr/bin/bash

# Termux Tunnel Setup Script
# This script automates the installation and setup of a public tunnel using Bore
# Author: kishore-education
# Date: 2025-10-25

set -e  # Exit on any error

echo "======================================"
echo "  Termux Tunnel Setup Script"
echo "======================================"
echo ""

# Step 1: Update packages
echo "[1/6] Updating Termux packages..."
pkg update -y && pkg upgrade -y

# Step 2: Install required packages
echo ""
echo "[2/6] Installing required packages..."
pkg install python rust -y

# Step 3: Install Bore CLI
echo ""
echo "[3/6] Installing Bore CLI (this may take a few minutes)..."
cargo install bore-cli

# Step 4: Add Bore to PATH
echo ""
echo "[4/6] Adding Bore to PATH..."
export PATH="$HOME/.cargo/bin:$PATH"

# Add to bashrc for permanent PATH
if ! grep -q "/.cargo/bin" ~/.bashrc; then
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
    echo "PATH added to ~/.bashrc"
fi

# Step 5: Stop any existing HTTP server on port 8080
echo ""
echo "[5/6] Stopping any existing HTTP server..."
pkill -f "http.server 8080" 2>/dev/null || true

# Step 6: Start Python HTTP server in background
echo ""
echo "[6/6] Starting Python HTTP server on port 8080..."
python -m http.server 8080 > /tmp/http-server.log 2>&1 &
HTTP_PID=$!
sleep 2

# Check if server started successfully
if ps -p $HTTP_PID > /dev/null; then
    echo "✓ HTTP server started successfully (PID: $HTTP_PID)"
else
    echo "✗ Failed to start HTTP server"
    exit 1
fi

# Start Bore tunnel
echo ""
echo "======================================"
echo "  Starting Bore Tunnel..."
echo "======================================"
echo ""
echo "Your server will be accessible at the URL shown below."
echo "Press Ctrl+C to stop the tunnel."
echo ""

bore local 8080 --to bore.pub