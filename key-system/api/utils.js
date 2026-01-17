const crypto = require('crypto');
const { MongoClient } = require('mongodb');

const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'InfernixAdmin2026';
const MONGODB_URI = process.env.MONGODB_URI;

let cachedClient = null;
let cachedDb = null;

async function connectToDatabase() {
  if (cachedClient && cachedDb) {
    return { client: cachedClient, db: cachedDb };
  }

  if (!MONGODB_URI) {
    throw new Error('MONGODB_URI not set in environment variables');
  }

  const client = await MongoClient.connect(MONGODB_URI);
  const db = client.db('infernix-keys');

  cachedClient = client;
  cachedDb = db;

  return { client, db };
}

function generateKey() {
  return 'INF-' + crypto.randomBytes(8).toString('hex').toUpperCase();
}

async function generate10Keys() {
  const { db } = await connectToDatabase();
  const collection = db.collection('keys');
  
  // Clear old keys
  await collection.deleteMany({});
  
  // Generate 10 new keys
  const keys = [];
  for (let i = 0; i < 10; i++) {
    keys.push({
      key: generateKey(),
      used: false,
      createdAt: new Date().toISOString()
    });
  }
  
  await collection.insertMany(keys);
  
  // Update last generated timestamp
  await db.collection('metadata').updateOne(
    { _id: 'lastGenerated' },
    { $set: { timestamp: new Date().toISOString() } },
    { upsert: true }
  );
  
  return keys;
}

async function should24HourReset() {
  const { db } = await connectToDatabase();
  const metadata = await db.collection('metadata').findOne({ _id: 'lastGenerated' });
  
  if (!metadata) return true;
  
  const lastGen = new Date(metadata.timestamp);
  const now = new Date();
  const hoursDiff = (now - lastGen) / (1000 * 60 * 60);
  
  return hoursDiff >= 24;
}

async function getKeysData() {
  const { db } = await connectToDatabase();
  const collection = db.collection('keys');
  
  // Check if we need to reset
  if (await should24HourReset()) {
    await generate10Keys();
  }
  
  const keys = await collection.find({}).toArray();
  const metadata = await db.collection('metadata').findOne({ _id: 'lastGenerated' });
  
  return {
    keys: keys,
    lastGenerated: metadata?.timestamp || null
  };
}

module.exports = {
  ADMIN_PASSWORD,
  getKeysData,
  generate10Keys,
  generateKey,
  connectToDatabase
};
