const { getKeysData } = require('./utils');

module.exports = async (req, res) => {
  try {
    const data = await getKeysData();
    const validKeys = data.keys.map(k => k.key).join('\n');
    res.setHeader('Content-Type', 'text/plain');
    res.send(validKeys);
  } catch (error) {
    console.error('Error:', error);
    res.status(500).send('Error retrieving keys');
  }
};
