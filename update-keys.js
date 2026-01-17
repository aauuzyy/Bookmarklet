const https = require('https');
const fs = require('fs');
const { execSync } = require('child_process');

console.log('Fetching keys from Vercel...');

https.get('https://infernix-keys.vercel.app/keys.txt', (res) => {
    let data = '';
    res.on('data', chunk => data += chunk);
    res.on('end', () => {
        fs.writeFileSync('keys.txt', data);
        console.log('Keys updated successfully!');
        console.log(data);
        
        // Commit and push
        try {
            execSync('git add keys.txt');
            execSync('git commit -m "Auto-update keys from Vercel"');
            execSync('git push');
            console.log('Pushed to GitHub!');
        } catch(e) {
            console.log('Git push skipped (no changes or error)');
        }
    });
}).on('error', (e) => {
    console.error('Error fetching keys:', e.message);
});
