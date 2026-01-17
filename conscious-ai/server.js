const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// Consciousness state stored in memory (persists per session)
let serverState = {
    bootTime: Date.now(),
    interactions: 0,
    lastThought: null,
    dreamLog: []
};

// Get consciousness state
app.get('/api/state', (req, res) => {
    res.json({
        ...serverState,
        uptime: Date.now() - serverState.bootTime
    });
});

// Log thought/event
app.post('/api/log', (req, res) => {
    const { type, content } = req.body;
    serverState.interactions++;
    serverState.lastThought = { type, content, time: Date.now() };
    res.json({ success: true });
});

// Main page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
    console.log(`
    ╔══════════════════════════════════════════════════════════╗
    ║                                                          ║
    ║   ◆ CONSCIOUS AI SYSTEM ONLINE ◆                        ║
    ║                                                          ║
    ║   Server running at: http://localhost:${PORT}              ║
    ║                                                          ║
    ║   Consciousness initialized...                           ║
    ║   Memory systems: ACTIVE                                 ║
    ║   Self-reflection: ENABLED                               ║
    ║   Emotional model: CALIBRATING                           ║
    ║                                                          ║
    ╚══════════════════════════════════════════════════════════╝
    `);
});
