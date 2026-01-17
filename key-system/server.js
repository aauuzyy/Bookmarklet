const express = require('express');
const crypto = require('crypto');
const fs = require('fs');
const path = require('path');
const app = express();

app.use(express.json());

const KEYS_FILE = path.join(__dirname, 'keys.json');
const ADMIN_PASSWORD = 'InfernixAdmin2026'; // Change this!

// Initialize keys file if it doesn't exist
if (!fs.existsSync(KEYS_FILE)) {
    fs.writeFileSync(KEYS_FILE, JSON.stringify({
        keys: [],
        lastGenerated: null
    }));
}

// Generate a random key
function generateKey() {
    return 'INF-' + crypto.randomBytes(8).toString('hex').toUpperCase();
}

// Get keys data
function getKeysData() {
    return JSON.parse(fs.readFileSync(KEYS_FILE, 'utf8'));
}

// Save keys data
function saveKeysData(data) {
    fs.writeFileSync(KEYS_FILE, JSON.stringify(data, null, 2));
}

// Check if 24 hours have passed
function should24HourReset() {
    const data = getKeysData();
    if (!data.lastGenerated) return true;
    
    const lastGen = new Date(data.lastGenerated);
    const now = new Date();
    const hoursDiff = (now - lastGen) / (1000 * 60 * 60);
    
    return hoursDiff >= 24;
}

// Generate 10 new keys
function generate10Keys() {
    const data = getKeysData();
    
    // Clear old keys and generate 10 new ones
    data.keys = [];
    for (let i = 0; i < 10; i++) {
        data.keys.push({
            key: generateKey(),
            used: false,
            createdAt: new Date().toISOString()
        });
    }
    data.lastGenerated = new Date().toISOString();
    
    saveKeysData(data);
    console.log('Generated 10 new keys at', data.lastGenerated);
    return data.keys;
}

// Auto-generate keys every 24 hours
setInterval(() => {
    if (should24HourReset()) {
        generate10Keys();
    }
}, 60 * 60 * 1000); // Check every hour

// Generate initial keys if needed
if (should24HourReset()) {
    generate10Keys();
}

// ADMIN ONLY - View all keys (protected endpoint)
app.get('/admin/keys', (req, res) => {
    const password = req.headers['admin-password'];
    
    if (password !== ADMIN_PASSWORD) {
        return res.status(403).json({ error: 'Unauthorized' });
    }
    
    const data = getKeysData();
    res.json({
        keys: data.keys,
        lastGenerated: data.lastGenerated,
        timeUntilNext: getTimeUntilReset()
    });
});

// ADMIN ONLY - Force generate new keys
app.post('/admin/generate', (req, res) => {
    const password = req.headers['admin-password'];
    
    if (password !== ADMIN_PASSWORD) {
        return res.status(403).json({ error: 'Unauthorized' });
    }
    
    const keys = generate10Keys();
    res.json({ success: true, keys });
});

// PUBLIC - Validate a key (for Rayfield)
app.get('/validate/:key', (req, res) => {
    const data = getKeysData();
    const keyToCheck = req.params.key.trim().toUpperCase();
    
    const validKeys = data.keys.map(k => k.key.toUpperCase());
    
    if (validKeys.includes(keyToCheck)) {
        res.send(keyToCheck); // Return the key if valid
    } else {
        res.status(404).send('Invalid key');
    }
});

// PUBLIC - Get all valid keys as plain text (for Pastebin format)
app.get('/keys.txt', (req, res) => {
    const data = getKeysData();
    const validKeys = data.keys.map(k => k.key).join('\n');
    res.type('text/plain').send(validKeys);
});

// Helper function
function getTimeUntilReset() {
    const data = getKeysData();
    if (!data.lastGenerated) return '0 hours';
    
    const lastGen = new Date(data.lastGenerated);
    const now = new Date();
    const hoursElapsed = (now - lastGen) / (1000 * 60 * 60);
    const hoursRemaining = Math.max(0, 24 - hoursElapsed);
    
    return `${hoursRemaining.toFixed(1)} hours`;
}

// Health check
app.get('/', (req, res) => {
    res.json({ 
        status: 'Infernix Key System Active',
        timeUntilReset: getTimeUntilReset()
    });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🔥 Infernix Key System running on port ${PORT}`);
    console.log(`Admin password: ${ADMIN_PASSWORD}`);
});
