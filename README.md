# Termux Tunnel Setup

Automated scripts to expose your Termux HTTP server to the internet using Bore tunnel.

## Quick Start

### First Time Setup
```bash
# Download the setup script
curl -O https://raw.githubusercontent.com/kishore-education/termux-tunnel-setup/main/setup-termux-tunnel.sh

# Make it executable
chmod +x setup-termux-tunnel.sh

# Run the setup (takes 3-5 minutes)
./setup-termux-tunnel.sh
```

### Starting the Tunnel (After Setup)
```bash
# Start with default port 8080
./start-tunnel.sh

# Or specify a custom port
./start-tunnel.sh 3000
```

### Stopping the Tunnel
```bash
./stop-tunnel.sh
```

### Check Status
```bash
./check-status.sh
```

## What Gets Installed

- **Python** - For running HTTP server
- **Rust** - Required for Bore CLI
- **Bore CLI** - Tunnel service to expose your server

## How It Works

1. Python HTTP server runs on localhost (default port 8080)
2. Bore creates a secure tunnel from `bore.pub` to your localhost
3. You get a public URL like `http://bore.pub:XXXXX`
4. Anyone can access your server via that URL

## Files Included

- `setup-termux-tunnel.sh` - One-time setup script
- `start-tunnel.sh` - Quick start tunnel
- `stop-tunnel.sh` - Stop all tunnels and servers
- `check-status.sh` - Check what's running

## Troubleshooting

### Port Already in Use
```bash
# Stop existing server
pkill -f "http.server 8080"

# Then start again
./start-tunnel.sh
```

### Bore Not Found
```bash
# Add to PATH manually
export PATH="$HOME/.cargo/bin:$PATH"
```

### Server Won't Start
```bash
# Check if Python is installed
python --version

# Reinstall if needed
pkg install python -y
```

## Limitations

- Random port assigned each time (e.g., bore.pub:38950)
- Tunnel stops when you close Termux or lose internet
- Free service with no guaranteed uptime
- No built-in authentication

## Security Warning

⚠️ **Your server will be publicly accessible!** Anyone with the URL can view your files. Don't expose sensitive data.

## Advanced Usage

### Serve a Specific Directory
```bash
cd /path/to/your/directory
python -m http.server 8080 &
bore local 8080 --to bore.pub
```

### Run in Background (Persistent)
```bash
# Install termux-services
pkg install termux-services

# Create a service (advanced - requires additional setup)
```

## Alternative Services

If you need more features, consider:
- **Ngrok** - Custom domains, authentication (requires account)
- **Cloudflare Tunnel** - Unlimited bandwidth (may not work on all devices)
- **Serveo** - SSH-based (less reliable)

## License

MIT License - Feel free to modify and share!

## Author

Created by [@kishore-education](https://github.com/kishore-education)