const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const router = express.Router();
const db = require('./db'); // Assume you have a separate db.js for MySQL connection

// Signup Route
router.post('/signup', async (req, res) => {
  const { username, password } = req.body;
  const hashedPassword = await bcrypt.hash(password, 8);

  db.query('SELECT username FROM users WHERE username = ?', [username], async (error, results) => {
    if (results.length > 0) {
      return res.status(400).send('User already exists');
    }

    db.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, hashedPassword], (error, results) => {
      if (error) {
        return res.status(500).send('Error in saving');
      }
      const userId = results.insertId;
      const token = jwt.sign({ id: userId }, process.env.JWT_SECRET);
      res.status(201).send({ token });
    });
  });
});

// Signin Route
router.post('/signin', async (req, res) => {
  const { username, password } = req.body;

  db.query('SELECT * FROM users WHERE username = ?', [username], async (error, results) => {
    if (results.length == 0 || !(await bcrypt.compare(password, results[0].password))) {
      return res.status(400).send('Username or password is incorrect');
    }

    const user = results[0];
    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET); // Include the user's ID in the token
    res.status(200).send({ token });
  });
});

module.exports = router;
