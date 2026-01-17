# MongoDB Atlas Setup - Step by Step

## Step 1: Create MongoDB Atlas Account

1. Go to **https://www.mongodb.com/cloud/atlas/register**
2. Sign up with Google/GitHub or email (FREE forever)
3. Click **"Create"** when asked to build a cluster

## Step 2: Create Free Cluster

1. Choose **M0 (FREE)** tier
2. Pick a cloud provider (AWS recommended)
3. Pick a region close to you
4. Cluster name: **infernix-keys** (or any name)
5. Click **"Create Deployment"**

## Step 3: Create Database User

1. You'll see "Security Quickstart"
2. **Username:** `infernix-admin` (or your choice)
3. **Password:** Click "Autogenerate Secure Password" and **COPY IT**
4. Click **"Create Database User"**

## Step 4: Whitelist IP Addresses

1. Still in Security Quickstart
2. Click **"Add My Current IP Address"**
3. Then click **"Add Entry"** 
4. Enter `0.0.0.0/0` to allow access from anywhere (needed for Vercel)
5. Click **"Finish and Close"**

## Step 5: Get Connection String

1. Click **"Go to Database"**
2. Click **"Connect"** button on your cluster
3. Choose **"Drivers"**
4. Copy the connection string (looks like):
   ```
   mongodb+srv://infernix-admin:<password>@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority
   ```
5. **Replace `<password>`** with the password you copied earlier
6. **SAVE THIS STRING** - you'll need it next!

## Step 6: Add to Vercel Environment Variables

### Option A: Via Vercel CLI
```bash
cd key-system
vercel env add MONGODB_URI
```
Paste your connection string when prompted.

### Option B: Via Vercel Dashboard
1. Go to your project on Vercel
2. Click **Settings** → **Environment Variables**
3. Add new variable:
   - **Name:** `MONGODB_URI`
   - **Value:** Your connection string
4. Check all environments (Production, Preview, Development)
5. Click **"Save"**

## Step 7: Deploy to Vercel

```bash
cd key-system
npm install
vercel --prod
```

## Step 8: Test Your Deployment

Replace `YOUR-URL` with your Vercel URL:

```bash
# View all keys
curl https://YOUR-URL.vercel.app/keys.txt

# Admin view (with your admin password)
curl -H "admin-password: InfernixAdmin2026" https://YOUR-URL.vercel.app/admin/keys
```

## Step 9: Update Lua Script

Edit `Infernix-Spy.lua` line 27:
```lua
Key = {"https://YOUR-URL.vercel.app/keys.txt"}
```

---

## 🎉 Done!

Your keys are now:
- ✅ Stored in MongoDB (persistent forever)
- ✅ Auto-regenerate every 24 hours
- ✅ Accessible via Vercel serverless functions
- ✅ Fast and reliable

## Troubleshooting

**"MongoServerError: bad auth"**
- Check your password in the connection string
- Make sure you replaced `<password>` with actual password

**"Connection timeout"**
- Make sure you whitelisted `0.0.0.0/0` in Network Access
- Wait a few minutes for changes to propagate

**"MONGODB_URI not set"**
- Make sure you added the environment variable to Vercel
- Redeploy after adding: `vercel --prod`
