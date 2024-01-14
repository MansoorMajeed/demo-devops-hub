# Backend API


Signin

```
 curl -v -X POST 127.0.0.1:5000/api/auth/signin -H 'Content-type: application/json' -d '{"username":"testuser", "password":"testpassword"}'
```

Creating post
```
 curl -v -X POST 127.0.0.1:5000/api/posts -H 'Content-type: application/json' -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzA1MjY5MzczfQ.7_FEZIoO3x4LkB09G_IRmabwYW_UC4wg-6ABKweU-M0' -d '{"content": "Hello"}'
```

