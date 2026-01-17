const { getKeysData } = require('./utils');

module.exports = async (req, res) => {
  try {
    const data = await getKeysData();
    const keyToCheck = req.query.key || req.url.split('/validate/')[1];
    
    if (!keyToCheck) {
      return res.status(400).send('No key provided');
    }
    
    const cleanKey = keyToCheck.trim().toUpperCase();
    const validKeys = data.keys.map(k => k.key.toUpperCase());
    
    if (validKeys.includes(cleanKey)) {
      res.send(cleanKey);
    } else {
      res.status(404).send('Invalid key');
    }
  } catch (error) {
    console.error('Error:', error);
    res.status(500).send('Error validating key');
  }
};
