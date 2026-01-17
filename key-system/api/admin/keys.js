const { ADMIN_PASSWORD, getKeysData } = require('../utils');

module.exports = async (req, res) => {
  try {
    const password = req.headers['admin-password'];
    
    if (password !== ADMIN_PASSWORD) {
      return res.status(403).json({ error: 'Unauthorized' });
    }
    
    const data = await getKeysData();
    const timeUntilReset = () => {
      if (!data.lastGenerated) return '0 hours';
      const lastGen = new Date(data.lastGenerated);
      const now = new Date();
      const hoursElapsed = (now - lastGen) / (1000 * 60 * 60);
      const hoursRemaining = Math.max(0, 24 - hoursElapsed);
      return `${hoursRemaining.toFixed(1)} hours`;
    };

    res.json({
      keys: data.keys,
      lastGenerated: data.lastGenerated,
      timeUntilNext: timeUntilReset()
    });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
