// index.js
// node app starts

// Init project
var express = require('express');
var app = express();

// Enable CORS (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
// so that the API is remotely testable by FCC
var cors = require('cors');
app.use(cors({ optionsSuccessStatus: 200 }));  // some legacy browsers choke on 204

// Serve static files
// http://expressjs.com/en/starter/static-files.html
app.use(express.static('public'));

// Serve index.html
// http://expressjs.com/en/starter/basic-routing.html
app.get("/", function (req, res) {
  res.sendFile(__dirname + '/views/index.html');
});

// API endpoint for Timestamp Microservice
app.get("/api/:date?", function (req, res) {
  let dateParam = req.params.date;
  let date;

  if (!dateParam) {
    console.log("Empty date parameter: returning current time.");
    date = new Date();
  } else {
    if (/^\d+$/.test(dateParam)) {
      console.log("Parsing Unix timestamp.");
      date = new Date(parseInt(dateParam));
    } else {
      console.log("Parsing date string.");
      date = new Date(dateParam);
    }
  }

  if (isNaN(date.getTime())) {
    console.log("Invalid date encountered.");
    return res.json({ error: "Invalid Date" });
  }

  res.json({
    unix: date.getTime(),
    utc: date.toUTCString()
  });
});

// Listen on port set in environment variable or default to 3000
var listener = app.listen(process.env.PORT || 3000, function () {
  console.log('Your app is listening on port ' + listener.address().port);
});
