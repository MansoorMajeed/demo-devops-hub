const express = require('express');
const router = express.Router();
const db = require('./db');

// Middleware to verify JWT token
const verifyToken = require('./verifyToken');

// Create a new post
router.post('/', verifyToken, (req, res) => {

  const user_id = req.user.id;
  const { content } = req.body;
  db.query('INSERT INTO posts (user_id, content) VALUES (?, ?)', [user_id, content], (error, results) => {
    if (error) {
      return res.status(500).send('Error in creating post');
    }
    res.status(201).send({ postId: results.insertId });
  });
});

// Get all posts
router.get('/', (req, res) => {
  db.query('SELECT * FROM posts', (error, results) => {
    if (error) {
      return res.status(500).send('Error in fetching posts');
    }
    res.status(200).send(results);
  });
});

// Update a post
router.put('/:postId', verifyToken, (req, res) => {
  const { content } = req.body;
  const { postId } = req.params;
  db.query('UPDATE posts SET content = ? WHERE id = ?', [content, postId], (error, results) => {
    if (error) {
      return res.status(500).send('Error in updating post');
    }
    res.status(200).send('Post updated successfully');
  });
});

// Delete a post
router.delete('/:postId', verifyToken, (req, res) => {
  const { postId } = req.params;
  db.query('DELETE FROM posts WHERE id = ?', [postId], (error, results) => {
    if (error) {
      return res.status(500).send('Error in deleting post');
    }
    res.status(200).send('Post deleted successfully');
  });
});

module.exports = router;
