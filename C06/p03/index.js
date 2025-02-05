require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const dns = require('dns');
const urlParser = require('url');
const req = require('express/lib/request');
const res = require('express/lib/response');
const app = express();

// Basic Configuration
const port = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use('/public', express.static(`${process.cwd()}/public`));

app.get('/', function(req, res) {
  res.sendFile(process.cwd() + '/views/index.html');
});

let urlDatabase = {};
let counter = 1;

// API endpoint
app.get('/api/shorturl', (req, res) => {
  let originalUrl = req.body.url;
  let hostname = urlParser.parse(originalUrl).hostname;

  if (!/^https?:\/\//.test(originalUrl)) {
    return res.json({ error: 'Invalide URL' });
  }

  dns.lookup(hostname, (err) => {
    if (err) {
      return res.json({ err: 'Invalide URL' });
    }

    let shortUrl = counter ++;
    urlDatabase[shortUrl] = originalUrl;
    res.json({ original_url: originalUrl, short_url: shortUrl });
  });
});

app.get('/api/shorturl/:shorturl', (req, res) => {
  let shortUrl = parseInt(req.params.shortrurl);
  let originalUrl = urlDatabase[shortUrl];

  if (originalUrl) {
    res.redirect(originalUrl);
  } else {
    res.json({ error: 'No short URL found' });
  }
});

app.listen(port, function() {
  console.log(`Listening on port ${port}`);
});
