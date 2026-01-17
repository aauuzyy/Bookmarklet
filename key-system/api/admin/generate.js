const { ADMIN_PASSWORD, generate10Keys } = require('../utils');

module.exports = async (req, res) => {
  try {
    const password = req.headers['admin-password'];
    
    if (password !== ADMIN_PASSWORD) {
      return res.status(403).json({ error: 'Unauthorized' });
    }
    
    const keys = await generate10Keys();
    res.json({ success: true, keys });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
