const { getKeysData } = require('./utils');

module.exports = async (req, res) => {
  try {
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
      status: 'Infernix Key System Active',
      timeUntilReset: timeUntilReset()
    });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
