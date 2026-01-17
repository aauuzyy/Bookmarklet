# Deploy to Vercel - Quick Guide

## ⚠️ Important Note
Vercel uses serverless functions which reset on each cold start. Keys will be regenerated periodically. For persistent storage, consider using Vercel KV or deploying to Render instead.

## Deployment Steps

### 1. Install Vercel CLI
```bash
npm install -g vercel
```

### 2. Login to Vercel
```bash
vercel login
```

### 3. Deploy
```bash
cd key-system
vercel
```

Follow the prompts:
- **Set up and deploy?** Yes
- **Which scope?** Your account
- **Link to existing project?** No
- **What's your project's name?** infernix-keys
- **In which directory is your code located?** ./

### 4. Set Environment Variable (Optional)
Change admin password:
```bash
vercel env add ADMIN_PASSWORD
```
Enter your custom password when prompted.

### 5. Production Deployment
```bash
vercel --prod
```

You'll get a URL like: `https://infernix-keys.vercel.app`

## Update Your Lua Script

Edit `Infernix-Spy.lua` line 27:
```lua
Key = {"https://infernix-keys.vercel.app/keys.txt"}
```

## Testing

View keys:
```bash
curl https://infernix-keys.vercel.app/keys.txt
```

Admin view (replace password):
```bash
curl -H "admin-password: InfernixAdmin2026" https://infernix-keys.vercel.app/admin/keys
```

## Alternative: Deploy via Vercel Dashboard

1. Go to https://vercel.com
2. Click "Add New" → "Project"
3. Import your Git repository
4. Set root directory to `key-system`
5. Click "Deploy"
