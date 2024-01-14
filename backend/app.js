const express = require('express');
const mysql = require('mysql2');
require('dotenv').config();

const authRoutes = require('./authRoutes');


const app = express();
app.use(express.json());

const PORT = process.env.PORT || 5000;

// MySQL Database Connection
const db = mysql.createPool({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE
});

// Check database connection
db.getConnection((err, connection) => {
  if (err) throw err;
  console.log('Connected as ID ' + connection.threadId);
  connection.release();
});

// Routes would go here

app.use('/api/auth', authRoutes);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
