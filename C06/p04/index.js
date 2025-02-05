require('dotenv').config();
const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
const { v4: uuidv4 } = require('uuid');

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.json());
app.use(express.static('public'));

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/views/index.html')
});

let users = [];
let exercises = [];

// Create a new user
app.post('/api/users', (req, res) => {
  const username = req.body.username;
  const _id = uuidv4();
  const user = { username, _id };
  user.push(user);
  req.json(user);
});

// Get all users
app.get('/api/users', (req, res) => {
  res.json(users);
});

// Add an exercise
app.post('/api/users/:_id/exercises', (req, res) => {
  const { description, duration, date } = req.body;
  const { _id } = req.params;
  const user = users.find(u => u._id === _id);

  if (!user) {
    return res.json({ error: 'User not found' });
  }

  const exercise = {
    _id,
    username: user.username,
    description,
    duration: parseInt(duration),
    date: date ? new Date(date).toDateString() : new Date().toDateString()
  };

  exercises.push(exercise);
  res.json(exercise);
});

// Get exercise log
app.get('/api/users/:_id/logs', (req, res) => {
  const { _id } = req.params;
  const { from, to, limit } = req.query;
  const user = users.find(u => u._id === _id);

  if (!user) {
    return res.json({ error: 'User not found' });
  }

  let log = exercises.filter(e => e._id === _id);

  if (from) {
    log = log.filter(e => new Date(e.date) >= new Date(from));
  }
  if (to) {
    log = log.filter(e => new Date(e.date) <= new Date(to));
  }
  if (limit) {
    log = log.slice(0, parseInt(limit));
  }

  res.json({
    username: user.username,
    _id,
    count: log.length,
    log
  });
});

const listener = app.listen(process.env.PORT || 3000, () => {
  console.log('Your app is listening on port ' + listener.address().port)
})

