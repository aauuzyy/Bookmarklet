# Infernix Key System

Automated key generation system that creates 10 new keys every 24 hours.

## Setup

1. Install dependencies:
```bash
npm install
```

2. Change the admin password in `server.js` (line 10)

3. Run the server:
```bash
npm start
```

## Deployment

### Deploy to Render (Recommended - Free):

1. Go to https://render.com
2. Sign up with GitHub
3. Click "New +" → "Web Service"
4. Connect your GitHub repo
5. Set:
   - **Name:** infernix-keys
   - **Environment:** Node
   - **Build Command:** `npm install`
   - **Start Command:** `npm start`
6. Click "Create Web Service"

You'll get a URL like: `https://infernix-keys.onrender.com`

### Deploy to Replit (Alternative):

1. Go to https://replit.com
2. Create new Repl → Import from GitHub
3. Select your repo → `/key-system` folder
4. Click "Run"

## Endpoints

### Public Endpoints:

- `GET /` - Health check
- `GET /keys.txt` - Get all valid keys (use this URL in your script)
- `GET /validate/:key` - Validate a single key

### Admin Endpoints (Protected):

Add header: `admin-password: YOUR_PASSWORD`

- `GET /admin/keys` - View all keys with status
- `POST /admin/generate` - Force generate new 10 keys

## Usage

### Update Infernix-Spy.lua:

Change line 27 from:
```lua
Key = {"https://pastebin.com/raw/hEV49baM"}
```

To:
```lua
Key = {"https://YOUR-DEPLOYMENT-URL.onrender.com/keys.txt"}
```

### Admin Commands (PowerShell):

View all keys:
```powershell
curl -H "admin-password: InfernixAdmin2026" https://YOUR-URL.onrender.com/admin/keys
```

Force generate new keys:
```powershell
curl -X POST -H "admin-password: InfernixAdmin2026" https://YOUR-URL.onrender.com/admin/generate
```

## How it Works

1. Server generates 10 unique keys on startup
2. Every 24 hours, old keys are deleted and 10 new ones are generated
3. Keys are stored in `keys.json`
4. Only YOU can view keys using admin password
5. Script validates keys without exposing the full list

## Security

- Change `ADMIN_PASSWORD` immediately
- Never share your admin password
- Only share the key validation endpoint with users
- Keys automatically rotate every 24 hours
