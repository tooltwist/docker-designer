var express = require('express');

// Constants
var PORT = 8080;

// App
var app = express();
app.get('/', function (req, res) {
	var CONTAINER_USERNAME = process.env.CONTAINER_USERNAME;
	
	res.send('Hello world, ' + CONTAINER_USERNAME + '.\n');
});

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);